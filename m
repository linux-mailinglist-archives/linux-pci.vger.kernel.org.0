Return-Path: <linux-pci+bounces-40042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE8C283B8
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 18:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7577E3499A2
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B127AC57;
	Sat,  1 Nov 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnscWgdp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9542135B9;
	Sat,  1 Nov 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016822; cv=none; b=m5QmJKFawRAID/fo5FLKeUaYl/pa/rGx/UTAw0nNOqyfApoFp2nFByZFSWtYClqDHUBbDQMNmocLq3Eox0YWQtriZmkyKaFMOO/Rs8SQGxsbFQk1FTG9rTh5wEVh3M/fcgsaRPW/yqVU9Juh7WVegWafiFSzVH4se18nxQXvn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016822; c=relaxed/simple;
	bh=Cv0pDJgDXyEUXqhIfLl1vBzkj96NpdjHrGVf8PIaWTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NryV1qcC1WUAI3nqGUy38ualy9xLxat9fd/Yr50QbVJ3ixQoxLuggtyN9araR/+v4UFPkOjAvbs2rx7tbSCp8OHT7AbgFCz2liQ1dH4iX6JW1tler/rNad6mpdoZv3Zv9+DYELpcZ5Jf7LI/LqZnFtvuaEwJcbPjl7vIVdTzRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnscWgdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E46C4CEF1;
	Sat,  1 Nov 2025 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762016821;
	bh=Cv0pDJgDXyEUXqhIfLl1vBzkj96NpdjHrGVf8PIaWTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnscWgdppKpnsIcg2bmV4SQBJ7rKAnseaFXV7RupPGd/rEY4jXOobWNUKtGpzpDIN
	 x+PRjYP+QSFUFSYusKVvgjCPuReKEORsiIEHvrpVrmvqKiwPyhvPX3FReeEiiJ153t
	 6zuw5NTHyJQrTXS9+pPYYdwt+7RnFc5Ig54eWqCz63BwV7b31SQtDjUT2IZK1na4Fe
	 42JtAWjRKYTrbsfdSxZHzy0Jfvttgs83qEafcPymdp/qA7dqZMNY2J7dTKWdUogpg0
	 wME2CJCD7lhk0htL7p+aTlrbiWfsyjnFG8/pJNbXuuxktO5spzuk10+NnJCO8bivh9
	 ZkAr51BnEYwhA==
Date: Sat, 1 Nov 2025 22:36:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lukas Wunner <lukas@wunner.de>, regressions@lists.linux.dev
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <emjne6l33e3hukef5ms7kubv6kkuvesqkw6ozojnzzdgvso7ma@rbpg2l5i3nno>
References: <545ac5c9-580c-5cf7-dd22-10dd79e6aabf@xenosoft.de>
 <AEBA92BD-B46D-4D1B-A4D1-645B276E34CF@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AEBA92BD-B46D-4D1B-A4D1-645B276E34CF@xenosoft.de>

On Sat, Nov 01, 2025 at 08:59:37AM +0100, Christian Zigotzky wrote:
> 
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> Oops, I made that fixup run too late.  Instead of the patch above, can
> you test the one below?
> 
> You'll likely see something like this, which is a little misleading
> because even though we claim "default L1" for 01:00.0 (or whatever
> your Radeon is), the fact that L0s and L1 are disabled at the other
> end of the link (00:00.0) should prevent us from actually enabling it:
> 
> pci 0000:00:00.0: Disabling ASPM L0s/L1
> pci 0000:01:00.0: ASPM: default states L1
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..27777ded9a2c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> * disable both L0s and L1 for now to be safe.
> */
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
> 
> /*
> * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> 
> —
> 
> Hi Bjorn,
> 
> Thanks for your patch. I patched the RC3 of kernel 6.18 with your new patch and compiled it again. Unfortunately the FSL Cyrus+ board doesn't boot with your new patch.
> 
> Sorry,
> 
> Christian
> 
> --
> Sent with BrassMonkey 33.9.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.9.1)
> 
> —-
> 
> What about with 
> 
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID, quirk_disable_aspm_l0s_l1);
> 

The issue is most likely with your Root Port rather than with the Radeon device.
So the quirk for Radeon won't fix the issue properly as it will affect other
host systems as well.

I guess Bjorn's change didn't help because the fixup ran before
pcie_aspm_init_link_state(). So even though the fixup disabled the ASPM link
state for Root Port, it got enabled by the default ASPM states enabled in
pcie_aspm_init_link_state().

Can you try doing fixup final as below?

```
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d97335a40193..74d8596b3f62 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  * disable both L0s and L1 for now to be safe.
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
```

Sorry, I guess we are asking for too many experiments to be done which might be
of trouble for you. But without direct access to the device, we had to do these
:(

Thanks for your help in debugging.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

