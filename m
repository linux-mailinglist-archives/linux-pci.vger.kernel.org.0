Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2057617EEBF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 03:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCJCkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 22:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgCJCkU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 22:40:20 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35BC24649;
        Tue, 10 Mar 2020 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583808019;
        bh=thZR4xgd9Km1KMkUd1NC2KGyM22wzciXvrzay68+csg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=usFrvnyhs6J8UIJOGPI1EylG6Nc/j7AVBXJ9CvFXNAYZZVTbScLk3nOW+E8qiASct
         OI3GrQNZ8wtuUwMeJ7HfvC9/m651DlPDuZZUnDKQoGQheOAJfFNl7gR1iLY0tLUlOM
         KuPkEkuUfoe1kphvo6Zc4AvXHhTpxz+eD1JKXT+4=
Date:   Mon, 9 Mar 2020 21:40:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Austin Bolen <austin_bolen@dell.com>
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200310024017.GA231196@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29fb514a0d86e9bcc75cec4ea8474cd4db33adbf.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Austin, tentative Linux patches on this git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/pcie?h=review/edr]

On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 System Firmware Intermediary
> (SFI) _OSC and DPC Updates ECR
> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
> Event Handling Implementation Note", page 10, Error Disconnect Recover
> (EDR) support allows OS to handle error recovery and clearing Error
> Registers even in FF mode. So create new API pci_aer_raw_clear_status()
> which allows clearing AER registers without FF mode checks.

I see that this ECR was released as an ECN a few days ago:
https://members.pcisig.com/wg/PCI-SIG/document/14076
Regrettably the title in the PDF still says "ECR" (the rendered title
*page* says "ENGINEERING CHANGE NOTIFICATION", but some metadata
buried in the file says "ECR - SFI _OSC Support and DPC Updates".

Anyway, I think I see the note you refer to (now on page 12):

  IMPLEMENTATION NOTE
  DPC Event Handling

  The flow chart below documents the behavior when firmware maintains
  control of AER and DPC and grants control of PCIe Hot-Plug to the
  operating system.

  ...

  Capture and clear device AER status. OS may choose to offline
  devices3, either via SW (not load driver) or HW (power down device,
  disable Link5,6,7). Otherwise process _HPX, complete device
  enumeration, load drivers

This clearly suggests that the OS should clear device AER status.
However, according to the intro text, firmware has retained control of
AER, so what gives the OS the right to clear AER status?

The Downstream Port Containment Related Enhancements ECN (sec 4.5.1,
table 4-6) contains an exception that allows the OS to read/write
DPC registers during recovery.  But

  - that is for *DPC* registers, not for AER registers, and

  - that exception only applies between OS receipt of the EDR
    notification and OS release of DPC by clearing the DPC Trigger
    Status bit.

The flowchart in the SFI ECN shows the OS releasing DPC before
clearing AER status:

  - Receive EDR notification

  - Cleanup - Notify and unload child drivers below Port

  - Bring Port out of DPC, clear port error status, assign bus numbers
    to child devices.

    I assume this box includes clearing DPC error status and clearing
    Trigger Status?  They seem to be out of order in the box.

  - Evaluate _OST

  - Capture and clear device AER status.

    This seems suspect to me.  Where does it say the OS is allowed to
    write AER status when firmware retains control of AER?

This patch series does things in this order:

  - Receive EDR notification (edr_handle_event(), edr.c)

  - Read, log, and clear DPC error regs (dpc_process_error(), dpc.c).

    This also clears AER uncorrectable error status when the relevant
    HEST entries do not have the FIRMWARE_FIRST bit set.  I think this
    is incorrect: the test should be based the _OSC negotiation for
    AER ownership, not on the HEST entries.  But this problem
    pre-dates this patch series.

  - Clear AER status (pci_aer_raw_clear_status(), aer.c).

    This is at least inside the EDR recovery window, but again, I
    don't see where it says the OS is allowed to write the AER status.

  - Attempt recovery (pcie_do_recovery(), err.c)

  - Clear DPC Trigger Status (dpc_reset_link(), dpc.c)

  - Evaluate _OST (acpi_send_edr_status(), edr.c)

What am I missing?

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e57e78b619f8..c239e6dd2542 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -655,6 +655,7 @@ extern const struct attribute_group aer_stats_attr_group;
>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  void pci_aer_clear_device_status(struct pci_dev *dev);
>  int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
> +int pci_aer_raw_clear_status(struct pci_dev *dev);
>  #else
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
> @@ -665,6 +666,7 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  #endif
>  
>  #ifdef CONFIG_ACPI
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c0540c3761dc..41afefa562b7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -420,7 +420,16 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
>  }
>  
> -int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> +/**
> + * pci_aer_raw_clear_status - Clear AER error registers.
> + * @dev: the PCI device
> + *
> + * NOTE: Allows clearing error registers in both FF and
> + * non FF modes.
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int pci_aer_raw_clear_status(struct pci_dev *dev)
>  {
>  	int pos;
>  	u32 status;
> @@ -433,9 +442,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  	if (!pos)
>  		return -EIO;
>  
> -	if (pcie_aer_get_firmware_first(dev))
> -		return -EIO;
> -
>  	port_type = pci_pcie_type(dev);
>  	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>  		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> @@ -451,6 +457,14 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> +{
> +	if (pcie_aer_get_firmware_first(dev))
> +		return -EIO;
> +
> +	return pci_aer_raw_clear_status(dev);
> +}
> +
>  void pci_save_aer_state(struct pci_dev *dev)
>  {
>  	struct pci_cap_saved_state *save_state;
> -- 
> 2.25.1
> 
