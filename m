Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7F207BC6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405732AbgFXSxM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 24 Jun 2020 14:53:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46427 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405119AbgFXSxM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 14:53:12 -0400
Received: from c-67-160-6-8.hsd1.wa.comcast.net ([67.160.6.8] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1joAW5-0007Ib-6N; Wed, 24 Jun 2020 18:53:01 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id BA0645FEE7; Wed, 24 Jun 2020 11:52:58 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id AE2EB9FB38;
        Wed, 24 Jun 2020 11:52:58 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v2 1/2] PCI/ERR: Fix fatal error recovery for non-hotplug capable devices
In-reply-to: <25283.1591332444@famine>
References: <ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com> <25283.1591332444@famine>
Comments: In-reply-to Jay Vosburgh <jay.vosburgh@canonical.com>
   message dated "Thu, 04 Jun 2020 21:47:24 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3399.1593024778.1@famine>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 24 Jun 2020 11:52:58 -0700
Message-ID: <3400.1593024778@famine>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jay Vosburgh <jay.vosburgh@canonical.com> wrote:

>sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>
>From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>>Fatal (DPC) error recovery is currently broken for non-hotplug
>>capable devices. With current implementation, after successful
>>fatal error recovery, non-hotplug capable device state won't be
>>restored properly. You can find related issues in following links.
>>
>>https://lkml.org/lkml/2020/5/27/290
>>https://lore.kernel.org/linux-pci/12115.1588207324@famine/
>>https://lkml.org/lkml/2020/3/28/328
>>
>>Current fatal error recovery implementation relies on hotplug handler
>>for detaching/re-enumerating the affected devices/drivers on DLLSC
>>state changes. So when dealing with non-hotplug capable devices,
>>recovery code does not restore the state of the affected devices
>>correctly. Correct implementation should call report_slot_reset()
>>function after resetting the link to restore the state of the
>>device/driver.
>>
>>So use PCI_ERS_RESULT_NEED_RESET as error status for successful
>>reset_link() operation and use PCI_ERS_RESULT_DISCONNECT for failure
>>case. PCI_ERS_RESULT_NEED_RESET error state will ensure slot_reset()
>>is called after reset link operation which will also fix the above
>>mentioned issue.
>>
>>[original patch is from jay.vosburgh@canonical.com]
>>[original patch link https://lore.kernel.org/linux-pci/12115.1588207324@famine/]
>>Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
>	I've tested this patch set on one of our test machines, and it
>resolves the issue.  I plan to test with other systems tomorrow.

	I've done testing on two different systems that exhibit the
original issue and this patch set appears to behave as expected.

	Has anyone else (Yicong?) had an opportunity to test this?

	Can this be considered for acceptance, or is additional feedback
or review needed?

	-J

>>---
>> drivers/pci/pcie/err.c | 24 ++++++++++++++++++++++--
>> 1 file changed, 22 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>index 14bb8f54723e..5fe8561c7185 100644
>>--- a/drivers/pci/pcie/err.c
>>+++ b/drivers/pci/pcie/err.c
>>@@ -165,8 +165,28 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>> 	pci_dbg(dev, "broadcast error_detected message\n");
>> 	if (state == pci_channel_io_frozen) {
>> 		pci_walk_bus(bus, report_frozen_detected, &status);
>>-		status = reset_link(dev);
>>-		if (status != PCI_ERS_RESULT_RECOVERED) {
>>+		/*
>>+		 * After resetting the link using reset_link() call, the
>>+		 * possible value of error status is either
>>+		 * PCI_ERS_RESULT_DISCONNECT (failure case) or
>>+		 * PCI_ERS_RESULT_NEED_RESET (success case).
>>+		 * So ignore the return value of report_error_detected()
>>+		 * call for fatal errors. Instead use
>>+		 * PCI_ERS_RESULT_NEED_RESET as initial status value.
>>+		 *
>>+		 * Ignoring the status return value of report_error_detected()
>>+		 * call will also help in case of EDR mode based error
>>+		 * recovery. In EDR mode AER and DPC Capabilities are owned by
>>+		 * firmware and hence report_error_detected() call will possibly
>>+		 * return PCI_ERS_RESULT_NO_AER_DRIVER. So if we don't ignore
>>+		 * the return value of report_error_detected() then
>>+		 * pcie_do_recovery() would report incorrect status after
>>+		 * successful recovery. Ignoring PCI_ERS_RESULT_NO_AER_DRIVER
>>+		 * in non EDR case should not have any functional impact.
>>+		 */
>>+		status = PCI_ERS_RESULT_NEED_RESET;
>>+		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
>>+			status = PCI_ERS_RESULT_DISCONNECT;
>> 			pci_warn(dev, "link reset failed\n");
>> 			goto failed;
>> 		}
>>-- 
>>2.17.1

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
