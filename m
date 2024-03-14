Return-Path: <linux-pci+bounces-4802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CC87B74C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 06:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6781C219AB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 05:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECE19473;
	Thu, 14 Mar 2024 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1tMsfGt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D08F5B
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710394535; cv=none; b=OJRrHhfnQUKpKObT9h8a5yBBISGbUvZR3a4iZqqZYxR7yorhjrDQOts0RFUFp21qYvq9nUkBnfPVrY+840+QtcqEIqaDX/66rqTREtHO2EnmRvI0enB3+h4iTQva0majEQdYV0Ogxog5f5VFxP47sHCw9DTlUgi2nJg2uqTmXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710394535; c=relaxed/simple;
	bh=wnyc1qtSHvisNJejbCfK6hGNGLnBCEc4+ttrJj7mPOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNiSRQXhYnPVHgcEuHuwuHbEeJdaQMa8J2S0g566qkTiSgKljJjwNPnerejzbTHOJZ006rtRrqapoDsHfkpjHg83w1FfkYaR1Z57x3Nx4XHHLplKZluPAHXHJRTthJd//5SQI1PPNsX2q1+UHY3lhb1gIH7pn+MqXBu7jq9e/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1tMsfGt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dd10a37d68so5279605ad.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 22:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710394533; x=1710999333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fxO4CS6+v/R6FQk4VO/N/wHqH8l31febwKNwu3Ztp4g=;
        b=q1tMsfGtWmPk21sRg9iCgbn+CDUEAMPU7F909ioq+mtAbRfDBZW6+bhQ57uqlmjgC+
         8i/sE+RNZSWvRvSedfAmRMAjBCj6xaXrcnD4LsTfAvJoUBEuoS5OJN85EBPVbAxRCQkX
         aTxP9Ny2j24theJsxrrsV3r0u6Q4Kxd0iCviKyW3JZP2Yhkmw2VTTu7OQZJhKJVqwVEv
         ZDc7ykuyFlp4deshwEWp5jSRRp1P7KIdBLXnNYLB7xRXUjGGx++BJdGHRkIpt04+G/d8
         WDEvPugzaR16z4RbDgz3N0EhjadUP0ITX9f2lHpLerkWm9M4Z5bIwtbGthAROYnre9FP
         R0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710394533; x=1710999333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxO4CS6+v/R6FQk4VO/N/wHqH8l31febwKNwu3Ztp4g=;
        b=P5J+pGQ+sxIATvWdw4ZQ8hzPDsq7sShVnC4NA3IRx53sqHBFMbfT94oaG4bZ2k1CUO
         YYJlfL6Gm7vQaJLVinjl5aHAFbUlPgnTk0cngZIGgMlN6OlVHQNX1XyQFV2T8vUGFTth
         cQ68Kp1jKpyWDxHrHRH9ch2rGhsArGX+hsdSoViJj56BzaBo5AhVsCn5gna03Vmxg7aa
         5D3QU5e8YVNPc38KTGxU+TF9ILhzHWh9XCsb1NvCZagm26SxwWFKyTAi/pr2LQsKifgc
         /PqU/okrYLWnD2jCKUS+12RDNG/hQySyxnrZZKVf825lPOl57fAHeOWisR1L61W3hdRZ
         N5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX0+O+DVgMvJM9Qia6v+qqufvbI4wgm8QiA/Q2CYbgahWh3LZqCdz3xAY+KTh3ZCypZiZkhc67GBfrHnbJ3iJHgBV9/WZ63xilm
X-Gm-Message-State: AOJu0YwjjJkrm59C2kVdxIOKugV7TN8heWSOQxoOkGs1GCiDdfxUhFOw
	vuM84guZEXT/MDN2owROVB/uorsb9xu3emmW3nBQtCt4NAjuU490cfAxUpsmhA==
X-Google-Smtp-Source: AGHT+IFb62XIR+M7PYX+5Uez2c2mc4hqJpOmNcntEpkYpWIn+f1QcjfI7Q+ezp2c2yAm0E2EcviD6Q==
X-Received: by 2002:a17:902:9688:b0:1dc:499b:8e80 with SMTP id n8-20020a170902968800b001dc499b8e80mr816349plp.54.1710394532640;
        Wed, 13 Mar 2024 22:35:32 -0700 (PDT)
Received: from thinkpad ([117.213.99.94])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001de3f08d768sm442172plh.251.2024.03.13.22.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 22:35:32 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:05:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback to properly
 reset the endpoint devices
Message-ID: <20240314053526.GA3575@thinkpad>
References: <20240313150242.GA2656@thinkpad>
 <20240313191656.GA921158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313191656.GA921158@bhelgaas>

On Wed, Mar 13, 2024 at 02:16:56PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 13, 2024 at 08:32:42PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 13, 2024 at 09:36:14AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 13, 2024 at 05:39:22PM +0530, Manivannan Sadhasivam wrote:
> > > > PCIe host controller drivers are supposed to properly reset the endpoint
> > > > devices during host shutdown/reboot.
> 
> Where does this requirement to reset endpoints during host shutdown
> come from?  My working assumption is that .shutdown() needs to stop
> DMA and interrupts, based on this old thread:
> https://lore.kernel.org/all/61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org/
> 

Yes, it indeed need to stop DMA and interrupts since the endpoint is going to
a dormant state. But not everyone care about PERST# since it will be asserted
by the hw automaticallyt once the SoC goes to a powerdown state. That's what
happening even without this patch. Also, in most of the cases, during host
shutdown/reboot, the power to the endpoint will be cutoff and reapplied
(on reboot). So the endpoint will undergo cold boot and it would work as usual.

But, in some rare cases like the one I'm dealing with, power to the endpoint
device is not coming from the host. The endpoint here is another SoC that works
on its own. It just receives refclk from the host. So in this case, during host
shutdown/reboot, only PERST# will be asserted and refclk will be cutoff, but the
device will be kept powered on. Due to this, the device when it tries to
cleanup the state machine post PERST# assertion, it will crash because refclk
will be cutoff immediately.

And that is what being addressed with this patch.

I should admit that this issue is not very common and that's the reason no one
cared about it so far. Because, on PCs/Laptops, most likely the endpoint device
will be powercycled during reboot.

> > > > Currently, Qcom driver doesn't do
> > > > anything during host shutdown/reboot, resulting in both PERST# and refclk
> > > > getting disabled at the same time. This prevents the endpoint device
> > > > firmware to properly reset the state machine. Because, if the refclk is
> > > > cutoff immediately along with PERST#, access to device specific registers
> > > > within the endpoint will result in a firmware crash.
> 
> Does "PERST# getting disabled" mean PERST# is asserted or deasserted?
> 

PERST# assertion I meant. Will change the wording.

> > > > To address this issue, let's call qcom_pcie_host_deinit() inside the
> > > > shutdown callback, that asserts PERST# and then cuts off the refclk with a
> > > > delay of 1ms, thus allowing the endpoint device firmware to properly
> > > > cleanup the state machine.
> 
> This *adds* the qcom_pcie_shutdown() callback, right?
> 

Yeah. Will make it explicit.

> > > I guess this 1ms delay is the PERST_DELAY_US hidden inside
> > > qcom_ep_reset_assert()?  I assume the refclk disable is done by
> > > clk_bulk_disable_unprepare()?
> > 
> > Yes to both.
> > 
> > >   #define PERST_DELAY_US 1000
> > > 
> > >   qcom_pcie_shutdown
> > >     qcom_pcie_host_deinit
> > >       qcom_ep_reset_assert
> > >         gpiod_set_value_cansleep(pcie->reset, 1);
> > >         usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);  <--
> > >       phy_power_off(pcie->phy)
> > >       pcie->cfg->ops->deinit()
> > >         qcom_pcie_deinit_...
> > >           clk_bulk_disable_unprepare                         <--
> > > 
> > > Is there a spec citation for this delay requirement?  If not, how do
> > > we know 1ms is enough for whatever the firmware needs to do?
> > 
> > Both PCIe base spec and Electromechanical spec only mentions Tperst,
> > which is the minimum time PERST# should remain asserted. But there
> > is no mention about the time, refclk should be active.
> 
> I see Tperst mentioned in PCIe r6.0, sec 6.6.1, but AFAICS the value
> is only defined in PCIe CEM (r5.0, sec 2.9.2), which says 100us, and
> maybe other form factor specs.
> 

I'm not 100% sure that Tperst represents the minimum time to keep refclk active.

> If PERST_DELAY_US is enforcing Tperst, why is it 1000us instead of
> 100us?
> 

As I said above, I'm not sure if PERST_DELAY_US corresponds to Tperst. It
predates my work on this driver, but I'll check internally.

> > So I used the existing delay post PERST# assert in the driver. I do
> > not know if that is enough for all the endpoints out in the wild,
> > but atleast satisfies the requirement of the endpoint I'm working on
> > (which is another Qcom SoC in EP mode).
> > 
> > We can change the delay if someone reports any issue with the
> > existing one.  Atleast, that's the best we could do in this
> > situation.
> 
> I'm dubious about this.  If endpoints require a delay here to work
> properly, the spec should specify a minimum delay.  We can't make a
> reliable system based on "here's a guess and we'll update it if people
> report issues."  That makes me think this endpoint mode Qcom SoC
> dependency on a delay might itself be non spec-compliant.
> 

I wouldn't say "non spec compliant", but a usecase not addressed properly in the
spec. This Chip to Chip usecase (connecting two SoCs over PCIe bus where one
acting as host and another as endpoint with their own power supply), is not very
popular IMO.

- Mani

> > > Do other drivers require similar changes?
> > 
> > Most likely yes, but that also depends on when the drivers are
> > cutting off the refclk. Not all drivers are implementing the
> > shutdown callback, and even few of the ones implementing, do not
> > assert PERST# since it is optional.
> 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 2ce2a3bd932b..41434bc4761a 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -1618,6 +1618,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static void qcom_pcie_shutdown(struct platform_device *pdev)
> > > > +{
> > > > +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> > > > +
> > > > +	qcom_pcie_host_deinit(&pcie->pci->pp);
> > > > +}
> > > > +
> > > >  static const struct of_device_id qcom_pcie_match[] = {
> > > >  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > > >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > > > @@ -1670,5 +1677,6 @@ static struct platform_driver qcom_pcie_driver = {
> > > >  		.pm = &qcom_pcie_pm_ops,
> > > >  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > > >  	},
> > > > +	.shutdown = qcom_pcie_shutdown,
> > > >  };
> > > >  builtin_platform_driver(qcom_pcie_driver);
> > > > 
> > > > ---
> > > > base-commit: 51459eb30f88651d3688b9e95fed0f97767ececb
> > > > change-id: 20240313-pci-qcom-shutdown-d86298186560
> > > > 
> > > > Best regards,
> > > > -- 
> > > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

