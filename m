Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07D6B83D0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 22:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCMVMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 17:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCMVMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 17:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2528FBC5;
        Mon, 13 Mar 2023 14:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1290614BF;
        Mon, 13 Mar 2023 21:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1479CC433EF;
        Mon, 13 Mar 2023 21:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678741923;
        bh=7pHDCwjSyYBjKIi2jo6gMrexeoQMQqclXq25JlRTSmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lqRGtSSkhrLPviO5u1/rX8UCXuASgHZYa4Ot5CmDnIbo2h6U05jVO5TOsLEOX0X4F
         ILta0kAvAsz3A/5rwEVpxSj2K45MaOFyZ9N24Mtnya98h/66TcdiAdckBoW1IKamxf
         KCiVGf29KkF9gTr/04XDBbVpUdW6OUdH3TFI6lOg04D4OmokRjvA3xKHGHgEB+FAmj
         H3amMTwhX3bBhcuhROtFmFwHu4XmbXFMYOEkQzdVBMhWtsk9b/vdQBA6ZAcMnzLkvW
         fNVEfKy41c5T2ef4rr6w9xcggcnNEczfxU8doBZ+F3npBDgXxwzMNSr480fPJQeE9U
         9XmU8Q6wVNjcQ==
Date:   Mon, 13 Mar 2023 16:12:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Message-ID: <20230313211201.GA1540091@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228042137.1941024-2-gankulkarni@os.amperecomputing.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
> As per PCI specification (PCI Express Base Specification Revision
> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
> independently for ATS capability, however the STU(Smallest Translation
> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
> the associated PF's value applies to VFs.
> 
> In the current code, the STU is being configured while enabling the PF ATS.
> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
> associated PF already.
> 
> Adding a function pci_ats_stu_configure(), which can be called to
> configure the STU during PF enumeration.
> Latter enumerations of VFs can successfully enable ATS independently.

s/STU(Smallest/STU (Smallest/ (add space before paren)
s/Adding a function pci_ats_stu_configure()/Add pci_ats_stu_configure()/
s/Latter/Subsequent/

Add blank line between paragraphs (it looks like "Latter enumerations"
is intended to start a new paragraph).

> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Given an ack for the IOMMU patch, I'd be happy to merge both (and I
can do the commit log tweaks); just let me know.

One comment/question below.

> ---
>  drivers/pci/ats.c       | 33 +++++++++++++++++++++++++++++++--
>  include/linux/pci-ats.h |  3 +++
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..1611bfa1d5da 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_supported);
>  
> +/**
> + * pci_ats_stu_configure - Configure STU of a PF.
> + * @dev: the PCI device
> + * @ps: the IOMMU page shift
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
> +{
> +	u16 ctrl;
> +
> +	if (dev->ats_enabled || dev->is_virtfn)
> +		return 0;

I might return an error for the VF case on the assumption that it's
likely an error in the caller.  I guess one could argue that it
simplifies the caller if it doesn't have to check for PF vs VF.  But
the fact that STU is shared between PF and VFs is an important part of
understanding how ATS works, so the caller should be aware of the
distinction anyway.

> +
> +	if (!pci_ats_supported(dev))
> +		return -EINVAL;
> +
> +	if (ps < PCI_ATS_MIN_STU)
> +		return -EINVAL;
> +
> +	dev->ats_stu = ps;
> +	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
> +	ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
> +	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
> +
>  /**
>   * pci_enable_ats - enable the ATS capability
>   * @dev: the PCI device
> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  		return -EINVAL;
>  
>  	/*
> -	 * Note that enabling ATS on a VF fails unless it's already enabled
> -	 * with the same STU on the PF.
> +	 * Note that enabling ATS on a VF fails unless it's already
> +	 * configured with the same STU on the PF.
>  	 */
>  	ctrl = PCI_ATS_CTRL_ENABLE;
>  	if (dev->is_virtfn) {
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index df54cd5b15db..7d62a92aaf23 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -8,6 +8,7 @@
>  /* Address Translation Service */
>  bool pci_ats_supported(struct pci_dev *dev);
>  int pci_enable_ats(struct pci_dev *dev, int ps);
> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>  void pci_disable_ats(struct pci_dev *dev);
>  int pci_ats_queue_depth(struct pci_dev *dev);
>  int pci_ats_page_aligned(struct pci_dev *dev);
> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>  { return false; }
>  static inline int pci_enable_ats(struct pci_dev *d, int ps)
>  { return -ENODEV; }
> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
> +{ return -ENODEV; }
>  static inline void pci_disable_ats(struct pci_dev *d) { }
>  static inline int pci_ats_queue_depth(struct pci_dev *d)
>  { return -ENODEV; }
> -- 
> 2.38.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
