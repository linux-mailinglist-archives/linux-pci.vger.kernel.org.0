Return-Path: <linux-pci+bounces-17082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255F9D2C9F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3131F23141
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649BB1D357B;
	Tue, 19 Nov 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqyohioR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB21CF284
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037231; cv=none; b=WyfyPys/k4asUZjyEbTgXTUsMl76NEe9YOefWx2vcS1g4Gru0HP/+YjvEHBgmKRiML+UBwyXn5SeuGlBCnXxoglwxAUPj2vJ1y0Dh9Cf0ne3MvXakzoNEkJQH45qBplpqjQSRv2ouMeOHPBz4nHPk7tWGrU8OyqT8eNQkAHVS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037231; c=relaxed/simple;
	bh=IGuyCiEeRVQBa0f+pLIVqb5kjKJ8wkoq/YPKZ8/hlLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5iIt6JIcr6babsGAiKWWhgo49q/g/Xb3Y/N4VsVXDgKs6y4oONpj7KTm12JgsWVqfTBrU/R96AP/LvUv3C6wtNeXK+nGupeHIzCZDJqMs60zmCpItEgG+qJpav6/gZmLblnhzw5Ab+i9yr1GN2/9JkHBpNH64gtQI5srmaHyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqyohioR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-723db2798caso4698060b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732037229; x=1732642029; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zS4AZSYQDSJWTR09zl2bsQZg8GiGqzz+uxJOhaei/b8=;
        b=nqyohioRHcjQteqJB79qEJDfYeJMpk2F2xL7xpzUAgYc0HjchCMIY7LgAMNLqPnPHV
         SFSJL++3YGvdF5/Lz/PRmyrAlZiKu8+X0JLCXJ5Q31h3vwLu/q5CHmniwieDuHxVhGhY
         rKLGkKT6SHemcQgu9biwmsjU3JbmD9dh5nyWvNaUhUKbv+mRv4D82p7w8/gE7UHtGtjB
         o+fFy1fRfuiRHrHiWbTxeGobgg7+WHu80wfYmCZDgN28TDwsQpR40Nstt5tNVuduzBkK
         2vuLWiCIYl4fyOTFMaPcpoocHc+DHfSMpveUsqWu8KxBqRvoKiYO5fBiMl5l0kB/4UZf
         UiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037229; x=1732642029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zS4AZSYQDSJWTR09zl2bsQZg8GiGqzz+uxJOhaei/b8=;
        b=iPNHKv3Y2YPCcnuNTBjMB6C51pRDzHQ2pv8Yac+6xWw7P/9AGyfOhEIjBqtW4MLJdU
         zgcN3J5a0XXyASY4Lvd3YS9sFORZil0ktY6HLxsDSU3lG9dqBKi8qAMGlzBRdRF7HnJT
         aEV18GEMc+QOixmDu/btcKR7qTZNJU2gxkerp0pftB1cx9acm6fld5wvlGLx87H9AnwO
         zeZgr4Ys+YJKbp8KXnNM4eH5h3xONUgcLNIfxuB3bneHZqB9T6/Au2c6BZsJdbZEvRR2
         46C8SWi4GYkIp/CsKVc9welAUe/yvhG9hsYqpxBL97EpLeU7lDblL4RNWcV9k0VMWuXy
         /brA==
X-Forwarded-Encrypted: i=1; AJvYcCVpcvv+laL1awMUNETWr4FjKKv4vrsMy40GwD4QCrMPw7yPUeYKWGbksxOtMSJrCtVOgyhMX2Ww2xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpso7OvsxWNYPIJI0lV/8i0iZN/ShqynqX/MMmGx0HENN/JpRX
	fQjwV53BTPRYiS8QSl7JFF85kfRCRp7DIOEI3SfvoYe/A9hhfiA7bEquql+waw==
X-Google-Smtp-Source: AGHT+IHknS0o9tnZsixhP3HB5mxNWhuX1weGWThV74uMFmdHAX6Kf/aB9bNO3vo0XHUvkknj339AlQ==
X-Received: by 2002:a05:6a00:b8f:b0:724:6dcd:6c46 with SMTP id d2e1a72fcca58-72476bbab57mr21835867b3a.14.1732037228762;
        Tue, 19 Nov 2024 09:27:08 -0800 (PST)
Received: from thinkpad ([36.255.17.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0877sm8639826b3a.120.2024.11.19.09.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:27:08 -0800 (PST)
Date: Tue, 19 Nov 2024 22:57:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dullfire <dullfire@yahoo.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [Bug 219513] New: PCIe drivers do not bind
Message-ID: <20241119172704.skudguavz4nmdi4t@thinkpad>
References: <bug-219513-41252@https.bugzilla.kernel.org/>
 <20241119140434.GA2260828@bhelgaas>
 <CACMJSesxsADzGQyzi13QDGh-VwEO+mgyyGmSNEyyBiL6QRAWZw@mail.gmail.com>
 <52410459-d15b-4e18-a978-0c069f9cd292@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52410459-d15b-4e18-a978-0c069f9cd292@yahoo.com>

On Tue, Nov 19, 2024 at 10:57:26AM -0600, Dullfire wrote:
> 
> 
> On 11/19/24 08:16, Bartosz Golaszewski wrote:
> > On Tue, 19 Nov 2024 at 15:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >> On Tue, Nov 19, 2024 at 12:55:36PM +0000, bugzilla-daemon@kernel.org wrote:
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=219513
> >>>
> >>>           Hardware: Sparc64
> >>>           Priority: P3
> >>>           Reporter: dullfire@yahoo.com
> >>>         Regression: No
> >>>
> >>> Created attachment 307241
> >>>   --> https://bugzilla.kernel.org/attachment.cgi?id=307241&action=edit
> >>> debug info (some shell commands to check the PCIe devices and drivers)
> >>>
> >>> In linux-next (next-20241118), since
> >>> commit 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed
> >>> before the PCI client drivers")
> >>> PCIe drivers no longer bind (at least on the tested SPARCv9 system).
> >>>
> >>> It appears a "supplier" devlink is created, however it is are dormant. see
> >>> attached "bug-info.txt"
> >>
> >> Thanks for the report.  It sounds like you bisected this to
> >> 03cfe0e05650?  Can you attach a complete dmesg log to the bugzilla?
> >>
> >> This commit is queued for v6.13, and the merge window is now open, so
> >> if it's a regression, we need to resolve it or drop it ASAP.
> > 
> > Dullfire: is the DTS for this platform publicly available? If not, can
> > you at least post the PCI host controller and all its children nodes
> > here?
> > 
> > Bart
> 
> Bart: I attached to the bug report a dts extracted from the system.
> 
> Just a FYI: SPARC systems (including linux) get their device tree from the
> open firmware, which likely dynamically generates at least parts of it, so
> there is not a discrete source for it.
> 

Thanks Jonathan for the dts drop! Looks like the platform devices for the pcie
nodes were created elsewhere for the SPARC systems. Could you please test the
below diff and see if it fixes the issue?

```
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 7a061cc860d5..e70f4c089cd4 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -394,7 +394,7 @@ void pci_bus_add_device(struct pci_dev *dev)
         * PCI client drivers.
         */
        pdev = of_find_device_by_node(dn);
-       if (pdev) {
+       if (pdev && of_pci_is_supply_present(dn)) {
                if (!device_link_add(&dev->dev, &pdev->dev,
                                     DL_FLAG_AUTOREMOVE_CONSUMER))
                        pci_err(dev, "failed to add device link between %s and %s\n",
```

- Mani

> Regards,
> Jonathan Currier

-- 
மணிவண்ணன் சதாசிவம்

