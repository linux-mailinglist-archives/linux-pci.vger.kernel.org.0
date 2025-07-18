Return-Path: <linux-pci+bounces-32543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40425B0A8D0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 18:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9827AA063B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEFB2E7649;
	Fri, 18 Jul 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovSJFFsR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADE2E719D;
	Fri, 18 Jul 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857045; cv=none; b=cGKyxJW8sVmtD9NikiW/FmK44ltdVhKt8pMWPMeOwmDTuA+12WyQwcduFLkhtlQ5YhSvEz5UsHAV5iS1oyxTRqARm726R4cu1r4qjQYacml1+RFS+iEHiBLgTFP/m22e+w5hpmDiSEHZEmDEBhwZJG/sRzcv6MnyDxYj3kmkrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857045; c=relaxed/simple;
	bh=lOSfX0cJceqH2rFjYeh2J0Y7zv4DeFUyuTHduob0lD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fJybSOLBjGv+ARdEe45PFGc6WsGVyIZM4kI863YHYAH78/TBtJduhZKobu3QquFxsmf43NNJOYKyST5gpwE30m1oTi4vbIpnHC4e3OMXR9ciOhISkLKR1HcJ7EnoerM2EULo7oadBY6iQr1TZPvI0vZ8Pyeo3nNeBIIbhNCD6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovSJFFsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C68C4CEEB;
	Fri, 18 Jul 2025 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752857044;
	bh=lOSfX0cJceqH2rFjYeh2J0Y7zv4DeFUyuTHduob0lD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ovSJFFsRrnTfzxy88Gqm5UUB2d6MNVFnA/MiS699eKVt3zqMt6mybF9lY1uiwyn6c
	 /JTnjPM8zicJAcpzUtNnNJ4htJCiW1sIMdzS0k4hgeJ5FYzFkrStdiasCdLWbqm2Qe
	 8xm83dBM0TGAN+abTvv5bLCsZqxkKSBKri6va2kL2GehKGB6xOruYmW8dbtNUTBc++
	 A++XlngxjWnuEkzfW1IhZZZBBrilaE9yMJr4dU3sXh+0DpFKhHwe+PLQbHiMzecs+b
	 XvH9QfMrghBZjk0u0h5x9aT4hKBWxFSEo3GVZbIHFZRAa1em68Z6S69zn+q4o5nW05
	 K7J3f7pyVPF6A==
Date: Fri, 18 Jul 2025 11:44:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Weili Qian <qianweili@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liulongfang@huawei.com,
	Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] PCI: Add device-specific reset for Kunpeng virtual
 functions
Message-ID: <20250718164402.GA2701005@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed27a49-a437-66b1-8835-c3335edde07c@huawei.com>

On Fri, Jul 18, 2025 at 03:21:30PM +0800, Weili Qian wrote:
> On 2025/7/15 3:19, Bjorn Helgaas wrote:
> > On Sat, Jul 12, 2025 at 07:30:28PM +0800, Weili Qian wrote:
> >> Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
> >> Configuration RRS"), pci_dev_wait() polls PCI_COMMAND register until
> >> its value is not ~0(i.e., PCI_ERROR_RESPONSE). After d591f6804e7e,
> >> if the Configuration Request Retry Status Software Visibility (RRS SV)
> >> is enabled, pci_dev_wait() polls PCI_VENDOR_ID register until its value
> >> is not the reserved Vendor ID value 0x0001.
> >>
> >> On Kunpeng accelerator devices, RRS SV is enabled. However,
> >> when the virtual function's FLR (Function Level Reset) is not
> >> ready, the pci_dev_wait() reads the PCI_VENDOR_ID register and gets
> >> the value 0xffff instead of 0x0001. It then incorrectly assumes this
> >> is a valid Vendor ID and concludes the device is ready, returning
> >> successfully. In reality, the function may not be fully ready, leading
> >> to the device becoming unavailable.
> >>
> >> A 100ms wait period is already implemented before calling pci_dev_wait().
> >> In most cases, FLR completes within 100ms. However, to eliminate the
> >> risk of function being unavailable due to an incomplete FLR, a
> >> device-specific reset is added. After pcie_flr(), the function continues
> >> to poll PCI_COMMAND register until its value is no longer ~0.
> > 
> > As far as I can tell, there's nothing specific to Kungpeng devices
> > here.  We've seen a similar issue with Intel NVMe devices [1], and I
> > don't want a whole mess of quirks and device-specific reset methods.
> > 
> > We need some sort of generic solution for this.  My understanding was
> > that if devices are not ready 100ms after a reset, they are required
> > to respond with RRS.  Maybe these devices are defective.  Or maybe my
> > understanding is incorrect.  Either way, I think we should at least
> > check for a PCIe error before assuming that 0xffff is a valid
> > response.
> 
> A generic solution for this would be even better.
> 
> I tested the patch in [1], but it did not resolve the issue.
> According to the PCIe specification(e.g., Section 7.5.1
> PCI-Compatible Configuration Registers), the Vendor ID and Device ID
> for VFs are 0xffff.  However, if VFs cannot respond using the RRS
> mechanism, the pci_dev_wait() function reads the PCI_VENDOR_ID
> register and gets the value 0xffffffff. This value is considered an
> error on PCIe, causing pci_dev_wait() to continuously poll the
> register until a timeout occurs.

This is one of the problems: reading the VF Vendor ID gets ~0 in two
cases: (1) the config read was successful (the VF Vendor ID is
actually 0xffff), and (2) the config read failed and the RC
synthesized ~0 return data.  I hoped to be able to distinguish these
with the debug patch at [2], but so far it doesn't work as I expected,
so more debug is required.

[1] is an example of another way of doing a device-specific quirk.  It
doesn't really matter whether that way works for the Kunpeng device,
because I want to avoid any of these device-specific things if
possible.

> > [1] https://lore.kernel.org/linux-pci/20250611101442.387378-1-hui.wang@canonical.com/

[2] https://lore.kernel.org/r/20250701232341.GA1859056@bhelgaas

> >> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
> >> Signed-off-by: Weili Qian <qianweili@huawei.com>
> >> ---
> >>  drivers/pci/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index d7f4ee634263..1df1756257d2 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -4205,6 +4205,36 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
> >>  	return 0;
> >>  }
> >>  
> >> +#define KUNPENG_OPERATION_WAIT_CNT	3000
> >> +#define KUNPENG_RESET_WAIT_TIME		20
> >> +
> >> +/* Device-specific reset method for Kunpeng accelerator virtual functions */
> >> +static int reset_kunpeng_acc_vf_dev(struct pci_dev *pdev, bool probe)
> >> +{
> >> +	u32 wait_cnt = 0;
> >> +	u32 cmd;
> >> +
> >> +	if (probe)
> >> +		return 0;
> >> +
> >> +	pcie_flr(pdev);
> >> +
> >> +	do {
> >> +		pci_read_config_dword(pdev, PCI_COMMAND, &cmd);
> >> +		if (!PCI_POSSIBLE_ERROR(cmd))
> >> +			break;
> >> +
> >> +		if (++wait_cnt > KUNPENG_OPERATION_WAIT_CNT) {
> >> +			pci_warn(pdev, "wait for FLR ready timeout; giving up\n");
> >> +			return -ENOTTY;
> >> +		}
> >> +
> >> +		msleep(KUNPENG_RESET_WAIT_TIME);
> >> +	} while (true);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
> >>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
> >>  		 reset_intel_82599_sfp_virtfn },
> >> @@ -4220,6 +4250,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
> >>  		reset_chelsio_generic_dev },
> >>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
> >>  		reset_hinic_vf_dev },
> >> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_VF,
> >> +		reset_kunpeng_acc_vf_dev },
> >> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_SEC_VF,
> >> +		reset_kunpeng_acc_vf_dev },
> >> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_VF,
> >> +		reset_kunpeng_acc_vf_dev },
> >>  	{ 0 }
> >>  };
> >>  
> >> -- 
> >> 2.33.0
> >>
> > .
> > 

