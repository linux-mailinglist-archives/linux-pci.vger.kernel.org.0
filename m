Return-Path: <linux-pci+bounces-24432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E895A6C763
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 04:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06E03BC763
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 03:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792713D893;
	Sat, 22 Mar 2025 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUqQ4fZo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBE6F073
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742613834; cv=none; b=k0NmC8PD/lkqVQ4lh6zS9nTX25RxIxqtYaTqNivyZm3JM+DkR5QjYqeWRawReALpAvcCXU2GH3eMB5VL7OWqV/xsRwG501tyJkXCMeE4qRu0If/ua27ain90xSfAc2E/5Ja9/OSW4A10T2Cf8c3b32qrFV53dyINMVBrishcojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742613834; c=relaxed/simple;
	bh=J+nYWBW9R4qNA1uVL3OyPVg0gLlGaLZ+2sOrX3X1NQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMOpw0eMnYEi7o2BIRx2TXEGCAOI8s5Jmfjq1p/HQH+v3LAtBwcxD6uFbuJB/9ifAtp7j6ln7pLnmPRKuE8GHa78isURTShzlFveBZ1KJvTQiXXFiLPX7DSUAjRW25JiZZ0uhKkAXOl+aLA1N0W2JgHrvIh4jCnlevWJ3Lgn2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUqQ4fZo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so4499345a91.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 20:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742613830; x=1743218630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F4Hfl+6xzxImFIIBW6YfDpQ7N51w0n8dgIYu4tI/6Rk=;
        b=AUqQ4fZoqEeAY/iDHL4PebjFvtjR78i1HF2qYK1aXZuYStnabXJTtGVOvcL/I0Npdh
         tRZPyVX6t1TYjWQy9hHosYObdzuxUt8z36yuFwPMjy1XujgBRzdEYySKtVism3+zhlzR
         FCzNO/v3Zdl3K83xZP25EBxntQ7PWpJf1tBT8Ltbtdrgpwi/Qh166+K1O0/GpYoA0XMe
         3uR2OhrsF7EpgFiN8FuBwnv6vZuLjtYC0wLOHoC13fp7mhFN2UOts+nlreq8J68mBBa4
         XLpws+GlJZC2hatMx54lfpArRV929Hqp2BO2vzzBoHcFmTmu1KS9OfoEwhNnBki667z5
         oaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742613830; x=1743218630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4Hfl+6xzxImFIIBW6YfDpQ7N51w0n8dgIYu4tI/6Rk=;
        b=VgW2/5aSkJjFGllURhpuLmctTlnaWSA6FiQqkfOogo4xNijgtqhluiLTJ8J9TRnMTd
         PhUDuDOwr/L5cRa2YEPqsbY7twZHeAj+Z+ryMTezbGiEfDN41qmjdkmV6rQGnCD/3E7X
         Hy93j8xrM3NnF2hRYnvupjAq/fkLvUdsvw8xJ1y9ekh+nbY5NZZweXkFyt5UkTtVoDA6
         W042K1Frx+XUMY3papPDXtZOr9Q+SLhNhGNXep5LnS9XWbNmy3VlgkR9LkpBWCyfA08y
         aGznxC21H0F4IdoEDUKMhg+I/ysJmnYoKyKE2OgqqVXqAJMeeTCn7+HnmvB+vlvshbdY
         rqfA==
X-Forwarded-Encrypted: i=1; AJvYcCXNDTTaggF3I5dwxH+Okg2cgZ/bNBzOWPm9wGbRqF+YIJi/aAR5Sa9rRwRFmmjxjUuERdlKQ5ynkHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbAjpcWth5rrMZyV0shqrxgK3z0YBYK9z+dcuI+9aqpbwuIIG
	5Fkvc599oEpnt4gZes5Y1r7CWfOHFlf67xfwE8K3t0wV5FUaY+fd2geQmW1ZUA==
X-Gm-Gg: ASbGncuu0Pt06v4OEYRizrp9vw2XTcUYYcur888Dy12bT/Z6hg8Vw+kYbVSoVEAKiHa
	gCH4giC6gUSTJ91nQjSHtwk5VHjjuuDh1Rxf9XTdXlRHCfnhU0KVWi1qliSqkPD1odvGmD7q0uZ
	0DmlUGa0y6vLVpTRaOz7gKivr5bui6GoN/9kqxQhkDc43p5JuAXMbJNnImr5fdGHoIMyWpIj5qV
	MOp/1Pyjau3oE0zjOs86pa8azU5dwv/KLWi2uvrg9eqJtkdNWwzdlgh1Y4yc60ul+B6XVCLGxzK
	ocOKhdPs0BmTQtFRyyNZ2CuxNVaNG4s7BNoOtVR4d/uFFDuvJPjdVQwM
X-Google-Smtp-Source: AGHT+IGPFsj+Jc4VPlEpNP66wC46f7AMzXaFW0ZW65RN2uw3bRmj6At2hMvhMK1bxXhX0MVBgzGk5w==
X-Received: by 2002:a17:90b:2f4d:b0:2ff:62f8:9a12 with SMTP id 98e67ed59e1d1-3030fefe11cmr7509205a91.23.1742613830235;
        Fri, 21 Mar 2025 20:23:50 -0700 (PDT)
Received: from thinkpad ([220.158.156.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5d71b5sm3003208a91.18.2025.03.21.20.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 20:23:49 -0700 (PDT)
Date: Sat, 22 Mar 2025 08:53:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "devnull+manivannan.sadhasivam.linaro.org@kernel.org" <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Message-ID: <20250322032344.uypqhi3kg6nqixay@thinkpad>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
 <20250321025940.2103854-1-wei.fang@nxp.com>
 <2BFDC577-949F-49EE-A639-A21010FEEE0E@linaro.org>
 <PAXPR04MB85102429AE77159F8CAF914088DB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB85102429AE77159F8CAF914088DB2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Fri, Mar 21, 2025 at 07:04:24AM +0000, Wei Fang wrote:
> > Hi,
> > 
> > On March 21, 2025 8:29:40 AM GMT+05:30, Wei Fang <wei.fang@nxp.com>
> > wrote:
> > >@@ -2487,7 +2487,14 @@ static struct pci_dev *pci_scan_device(struct
> > pci_bus *bus, int devfn)
> > > 	struct pci_dev *dev;
> > > 	u32 l;
> > >
> > >-	pci_pwrctrl_create_device(bus, devfn);
> > >+	/*
> > >+	 * Create pwrctrl device (if required) for the PCI device to handle the
> > >+	 * power state. If the pwrctrl device is created, then skip scanning
> > >+	 * further as the pwrctrl core will rescan the bus after powering on
> > >+	 * the device.
> > >+	 */
> > >+	if (pci_pwrctrl_create_device(bus, devfn))
> > >+		return NULL;
> > >
> > >Hi Manivannan,
> > >
> > >The current patch logic is that if the pcie device node is found to
> > >have the "xxx-supply" property, the scan will be skipped, and then the
> > >pwrctrl driver will rescan and enable the regulators. However, after
> > >merging this patch, there is a problem on our platform. The .probe() of
> > >our device driver will not be called. The reason is that
> > >CONFIG_PCI_PWRCTL_SLOT is not enabled at all in our configuration file,
> > >and the compatible string of the device is also not added to the pwrctrl driver.
> > 
> > Hmm. So I guess the controller driver itself is enabling the supplies I believe
> > (which I failed to spot). May I know what platforms are affected?
> 
> Yes, the affected device is an Ethernet controller on our i.MX95
> platform, it has a "phy-supply" property to control the power of the
> external Ethernet PHY chip in the device driver.

Ah, I was not aware of any devices using 'phy-supply' in the pcie device node.

> This part has not been
> pushed upstream yet. So for upstream tree, there is no need to fix our
> platform, but I am not sure whether other platforms are affected by
> this on the upstream tree.
> 

Ok, this makes sense and proves that my grep skills are not bad :) I don't think
there is any platform in upstream that has the 'phy-supply' in the pcie node.
But I do not want to ignore this property since it is pretty valid for existing
ethernet drivers to control the ethernet device attached via PCIe.

> > 
> > > I think other
> > >platforms should also have similar problems, which undoubtedly make
> > >these platforms be unstable. This patch has been applied, and I am not
> > >familiar with this. Can you fix this problem? I mean that those
> > >platforms that do not use pwrctrl can avoid skipping the scan.
> > 
> > Sure. It makes sense to add a check to see if the pwrctrl driver is enabled or not.
> > If it is not enabled, then the pwrctrl device creation could be skipped. I'll send a
> > patch once I'm infront of my computer.
> > 
> 
> I don't know whether check the pwrctrl driver is enabled is a good idea,
> for some devices it is more convenient to manage these regulators in
> their drivers, for some devices, we may want pwrctrl driver to manage
> the regulators. If both types of devices appear on the same platform,
> it is not enough to just check whether the pinctrl driver is enabled.
> 

Hmm. Now that I got the problem clearly, I think more elegant fix would be to
ignore the device nodes that has the 'phy-supply' property. I do not envision
device nodes to mix 'phy-supply' and other '-supply' properties though.

Can you please try this untested diff:

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 7a806f5c0d20..f3c43a91e71c 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -734,6 +734,10 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
  * Check if the power supply for the PCI device is present in the device tree
  * node or not.
  *
+ * NOTE: This API currently excludes the 'phy-supply' property as it is not a
+ * standard PCI supply, but rather the supply to the external PHY like in the
+ * case of ethernet devices.
+ *
  * Return: true if at least one power supply exists; false otherwise.
  */
 bool of_pci_supply_present(struct device_node *np)
@@ -746,7 +750,8 @@ bool of_pci_supply_present(struct device_node *np)
 
        for_each_property_of_node(np, prop) {
                supply = strrchr(prop->name, '-');
-               if (supply && !strcmp(supply, "-supply"))
+               if (supply && !strcmp(supply, "-supply") &&
+                   strcmp(prop, "phy-supply"))
                        return true;
        }

> > But in the long run, we would like to move all platforms to use pwrctrl instead of
> > fiddling the power supplies in the controller driver (well that was the motivation
> > to introduce it in the first place).
> > 
> 
> I understand this, but it should be compatible with the old method
> instead of completely making the old method inoperable unless it
> can be confirmed that all platforms in the upstream have completed
> the conversion to use pwrctrl driver. Obviously, this is difficult to
> confirm. :(
> 

The motive is to get rid of the supply handling from the controller drivers. But
if there are some exceptions like the ethernet drivers, we can exclude them.

> > Once you share the platform details, I'll try to migrate it to use pwrctrl. Also,
> > please note that we are going to enable pwrctrl in ARM64 defconfig very soon.
> > So I'll try to fix the affected platforms before that happens.
> 
> I think the current pwrctrl driver should still be in the early stage. If I
> understand correctly, it should only enable the regulators when probing
> and disable the regulators when removing. This does not meet all the use
> cases at present. So I'm not sure how you can do the fixes for all the affected
> platforms in pwrctrl driver for different use cases?
> 
> For example, some Ethernet devices need to support suspend/resume and
> Wake-on-LAN (WOL). If WOL is not enabled, the power of the external PHY
> needs to be turned off when it enters suspend state. If WOL is enabled, the
> power of the external PHY needs to be kept on. So for this case, I think you
> need to at least add PM interfaces in pwrctrl driver. For the other use cases,
> other solutions may be needed.
> 

Yes, PM support is something I have on my todo list and required for other
usecases too.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

