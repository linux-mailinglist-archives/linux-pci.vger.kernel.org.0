Return-Path: <linux-pci+bounces-19663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B45FA0B77B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 13:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B61C1885E25
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358E22AE7E;
	Mon, 13 Jan 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ll3PqxeN"
X-Original-To: linux-pci@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F722CF12;
	Mon, 13 Jan 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772663; cv=none; b=ne0ewtmyFM/02wKb7/1mhahO6cxc7kEN0p/22xl25dhDrDxVwJwk9w2oAqheyxiWMRpRF2tb4GLF3EC4KiB7BagSNx6AaZXQjPtJqh8TwG/ZIVjINbM6de9qg+viPyoZcbbfXkSQP+3ToAGNC5b4s0Bt1E+Yi2UpdKKPqWBkvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772663; c=relaxed/simple;
	bh=3CRVPVziAnfz30YJXU07Jpfm++EmF0sYoPXENd1zFxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI3KrRdonC2pd8KJrLuALsDRNDHaDU7Dgq+GpMImlgsf8rZfTiz11XV6jF/p2v4KLnlbyZKk41TdjIZ0l+1lZaMdpupUSS9dAZe5gXGTWMBA54+uPz4w8Lj6znnq5KuJEMCHudHJ840GKsqw0J4WokxClIR77PwE1SNChnXaMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ll3PqxeN; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736772656; bh=n38ElMCM7QMzyPbciqtZcUX7Br1DwLZsFUyh6n2VHAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ll3PqxeNrm32Z+N0p7q9G7lRbIdpHls1/6Yoarrv1JRTLImH8Qh9uSSQQC4TFcxCZ
	 9wmeSgggnUJLZReBaaR8twOuxQv9IA0KtmMB5ZNt88N5DKQW6h+VwHPaV1pRdOucPP
	 YueMdvGMgw8VyKn1skwf7XJ8o9My2LIUnxTZbbOE=
Received: from [192.168.31.193] ([120.244.62.107])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id B2613E10; Mon, 13 Jan 2025 20:44:38 +0800
X-QQ-mid: xmsmtpt1736772278tq4uvgzz9
Message-ID: <tencent_D1EA17EA4011F145E9B70F3C08E57C37890A@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8fXu4sU/DrVzn2+1rHGqtHWxgSm/+6NsCVKKCZAWME1VuqUUG7R
	 nX26qobTm+tr5/TY28+pOkfCLyvmyUD2sT5FM6xnRMmOawPHXDdRAqVnFdUHmTViDlCZD7M+woFe
	 rGKZJL20fdr2Nu+UWPcEVJnuhi1EnvYai7jzeh52zIkNcs+tLxnsDTXFhTOm9l3axX9WDlFA0KDm
	 aAkEVm2gz/5JHL1LvjLxIe8O1C5GEg+Fmt83pXHxPYV1yXU4d9by3EXCaiCJLAYNgdVCTynDQP8s
	 82z0M4+Cc3k+dfbJjeVDVghSOWPkOzTiWtq3TU0DUe92PJqLHL/4gWetXfDc3XN7v2vGndqM/693
	 P1G8Q2tOqbL329HVG3nMXokANguoFLB0PDeA/MEtFfHWKsxzL0H3DaeIThwJa2S9z1mUoLhi+20x
	 fnrKaxzjjyrTBmlxgpQ79p/8KXBcNy0T5R/oTzNg8/UP8DKJD+4hsS7lPiRKPgT+KocPdQ1tX41e
	 GEf2Z6Kll5RxYDcNeJNr5l97gSAfRIElhIHxBhrQPeVmg56fWcEzG2CyjEqIzgm3ZT7h/JqSBSP8
	 nHFCKsh32YCpo/+bYsjrb07qvkX1+/MIOaL4km4QXGEWeeb5PNC4tRBE9dK0F8SuHL7enq4qh5Fs
	 mhuPHu9UlxWjYeI3aYAUCVWD1TfaPQOhdB6j1i0nNcJJyZtvjWu+4T2OIP3DkMm7BbndsFY2jePe
	 UC1W9Fw3YxcSm3C8xPB2qrwBTmjohN8e5KQ+9Y6GUKMOe2tF2CAxLn4UQVqeNpX3bspij+9oQKjZ
	 Cvb6SXvt9WB8sDR1Z6zRa4Q4LDpD9pe2xQvVJF3hldbml+3pu1FcgiAomrHfXQ9B6P3lQE73VLVb
	 SjJoJq56by86/9P9T0dPPdRbrUu71bBSd56FKc0m5fEhseXuD71IY1SI38Nz6XcxrGNqzyqLn/tu
	 49lq2kNSizOnWhiVqSFO8bkUyTdM8iRZpJtREzxygiq/Ccz/HX+YERcF34anQD9irCfwyu6hp94T
	 GN+xYtcQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <33faba73-04cb-4954-80e6-696d8013ee80@qq.com>
Date: Mon, 13 Jan 2025 20:44:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during
 hotplug testing
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 guojinhui.liam@bytedance.com, helgaas@kernel.org, lukas@wunner.de,
 ahuang12@lenovo.com, sunjw10@lenovo.com
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
 <alpine.DEB.2.21.2501111543050.18889@angie.orcam.me.uk>
Content-Language: en-US
From: Jiwei <jiwei.sun.bj@qq.com>
In-Reply-To: <alpine.DEB.2.21.2501111543050.18889@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/12/25 00:00, Maciej W. Rozycki wrote:
> On Fri, 10 Jan 2025, Jiwei Sun wrote:
> 
>> In order to fix the issue, don't do the retraining work except ASMedia
>> ASM2824.
> 
>  I yet need to go through all of your submission in detail, but this 
> assumption defeats the purpose of the workaround, as the current 
> understanding of the origin of the training failure and the reason to 
> retrain by hand with the speed limited to 2.5GT/s is the *downstream* 
> device rather than the ASMedia ASM2824 switch.
> 
>  It is also why the quirk has been wired to run everywhere rather than
> having been keyed by VID:DID, and the VID:DID of the switch is only 
> listed, conservatively, because it seems safe with the switch to lift the 
> speed restriction once the link has successfully completed training.
> 
>  Overall I think we need to get your problem sorted differently, because I 
> suppose in principle your hot-plug scenario could also happen with the 
> ASMedia ASM2824 switch as the upstream device and your NVMe storage 
> element as the downstream device.  Perhaps the speed restriction could be 
> always lifted, and then the bandwidth controller infrastructure used for 
> that, so that it doesn't have to happen within `pcie_failed_link_retrain'?

According to our test, the following modification can fix the issue in our
test machine.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index 02d2e16672a8..9ca051b86878 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -97,10 +97,6 @@ static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
  */
 int pcie_failed_link_retrain(struct pci_dev *dev)  {
-       static const struct pci_device_id ids[] = {
-               { PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
-               {}
-       };
        u16 lnksta, lnkctl2;
        int ret = -ENOTTY;
 
@@ -128,8 +124,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
        }
 
        if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-           (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-           pci_match_id(ids, dev)) {
+           (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == 
+ PCI_EXP_LNKCTL2_TLS_2_5GT) {
                u32 lnkcap;

                pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");

But I don't know if the above modification will have any other negative effects
on other devices. Could you please share your thoughts?

Thanks，
Regards，
Jiwei

> 
>   Maciej


