Return-Path: <linux-pci+bounces-4804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A9D87B7E7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 07:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD622851C2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 06:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B5D27E;
	Thu, 14 Mar 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMZ4aHB/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477D33F6;
	Thu, 14 Mar 2024 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397544; cv=none; b=c8uN+SWta7njx6QqLdAyoDj0peOI4wOTFth7pOmouzs2R37c2ggeVJBs2ZtkBtyt3igrUPFTiNn0mngCpTWcveo7mIfeuEHnD2+AR91d+ZUeQbd/zwDljLzqPUhNwKUR2x4sc+61T5pUnttYZmMfKdiLENL1NYikDbeoCApCLk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397544; c=relaxed/simple;
	bh=P8M3al2TXWi7OrbIZG/+8S+siTvqvr3JesSMso9r9xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI35y9J031quuLCZya4tlMjkf3f7DSwv9iqVdG7tqW8Dh/oEFDzMKRbruix12+wATtWtFAxilHTxczbsUDsiSu7CUhc1uwdHc95S7eXyuJkckr0Lt/Gl3RfTgfHIs9GPpoidvjrzXE65FOV28hp/sfUE6y8LGJCSK9zPfuBLzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMZ4aHB/; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a14d7f0e66so286984eaf.1;
        Wed, 13 Mar 2024 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710397541; x=1711002341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UjUnNqXyI+5ssZ3QF9wt/A+RQXIEGG+CNjU7FVUOLcc=;
        b=eMZ4aHB/oTD1aKoSlHrP+K7rtLcQTfghcm5mOZTPF4r9nb2+zxaKHkICJcsyqB813Z
         LqI09464BTW/YX9cMBO4b7zcX/P46IZlcJ/KhXnazAFBMe0KSxnF3sLIoWelUvNunq11
         DdovlnAwlj+kDi3FYpJ8sZnlGTS6DwounYpnyQFV2HdGsz0WZptKMkwruEfkfH2GJ3dT
         HJ7w95BolkuVXRL663WJU/gSB7hDbgIbtj6DpPjv7C8HaKItP8xQOM7iQk5B6JK/wW04
         SWI63sjmF7dFsQyLFJR/3freM5Yc4dm5F2zwh6vetFt6Ujgp8Pnl0thv3WTfMoWpLgf2
         BRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710397541; x=1711002341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjUnNqXyI+5ssZ3QF9wt/A+RQXIEGG+CNjU7FVUOLcc=;
        b=PawK1aIg44IhYqC1RViWiBzVKUXmigfulmcRUJJETWerMKX+T3MPQ+bLRZ0cAcdv3i
         H1CmksvjuanpoPB9z8p3gYwO+QkMASpDNEU+V1Lystka/+ZuH+CP/XtuvDxuXb7I08w3
         ll+pV0bu79c3wPDqVmDaRx3/mcLZkrOOlFHNeImMBhZf4JzMFafs/VhTn+2sJRbJkUID
         pj+NTrxnMGh/facJZonAcJYJQltXvHgwtz+WCn17PlLszR5CqKlk2p27GjlyxT4D79Ji
         NhArJKtrmB/aS9LJINrrHNUHHDZFKRPHS4ZnRUygzMXGfgitGFArSNsdKZ4yD1kbE6VD
         wGUw==
X-Forwarded-Encrypted: i=1; AJvYcCWy7WtEbnakv8BTBVvo3Soo6TYmm20ISdIL+2F375iDpebi630IL/4ai415dekDMCPZpmX26Bwv803c7PMLB+GBipd/5UMJD0+N+MU4GlQoy/Lw5U5HPhWQDpTujjHREv4Y85q9mmQJoHHvNV+7DGbHUl22dIZJwEpAvZgIbZKy3cWu/kF3KQ==
X-Gm-Message-State: AOJu0YyYAnIJ7hlg8YWe2RL2CTvuMyvoT7pmM4yMp+uTVBKvWgP810jw
	wqHkY7QgTFCbdsWzuZWQaymu3nklL1gbVGWQeK20KDMsfGncqZpn
X-Google-Smtp-Source: AGHT+IEjFUx7UzLcy7o+O4qJTgP8mPbR2fSXTQWv1tuhiXqnlzBD1/tl8lSfGqw3dURDjiA9wNCZuA==
X-Received: by 2002:a05:6359:7c25:b0:17b:ee6f:b6ae with SMTP id xm37-20020a0563597c2500b0017bee6fb6aemr1109250rwb.9.1710397541235;
        Wed, 13 Mar 2024 23:25:41 -0700 (PDT)
Received: from thinkpad ([117.213.99.94])
        by smtp.gmail.com with ESMTPSA id b21-20020a63d315000000b005cf450e91d2sm684259pgg.52.2024.03.13.23.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 23:25:40 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:55:32 +0530
From: Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback to properly
 reset the endpoint devices
Message-ID: <20240314062532.GB4831@thinkpad>
References: <20240313150242.GA2656@thinkpad>
 <20240313191656.GA921158@bhelgaas>
 <20240314053526.GA3575@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314053526.GA3575@thinkpad>

On Thu, Mar 14, 2024 at 11:05:32AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 13, 2024 at 02:16:56PM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 13, 2024 at 08:32:42PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Mar 13, 2024 at 09:36:14AM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Mar 13, 2024 at 05:39:22PM +0530, Manivannan Sadhasivam wrote:
> > > > > PCIe host controller drivers are supposed to properly reset the endpoint
> > > > > devices during host shutdown/reboot.
> > 
> > Where does this requirement to reset endpoints during host shutdown
> > come from?  My working assumption is that .shutdown() needs to stop
> > DMA and interrupts, based on this old thread:
> > https://lore.kernel.org/all/61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org/
> > 
> 
> Yes, it indeed need to stop DMA and interrupts since the endpoint is going to
> a dormant state. But not everyone care about PERST# since it will be asserted
> by the hw automaticallyt once the SoC goes to a powerdown state. That's what
> happening even without this patch. Also, in most of the cases, during host
> shutdown/reboot, the power to the endpoint will be cutoff and reapplied
> (on reboot). So the endpoint will undergo cold boot and it would work as usual.
> 
> But, in some rare cases like the one I'm dealing with, power to the endpoint
> device is not coming from the host. The endpoint here is another SoC that works
> on its own. It just receives refclk from the host. So in this case, during host
> shutdown/reboot, only PERST# will be asserted and refclk will be cutoff, but the
> device will be kept powered on. Due to this, the device when it tries to
> cleanup the state machine post PERST# assertion, it will crash because refclk
> will be cutoff immediately.
> 
> And that is what being addressed with this patch.
> 
> I should admit that this issue is not very common and that's the reason no one
> cared about it so far. Because, on PCs/Laptops, most likely the endpoint device
> will be powercycled during reboot.
> 
> > > > > Currently, Qcom driver doesn't do
> > > > > anything during host shutdown/reboot, resulting in both PERST# and refclk
> > > > > getting disabled at the same time. This prevents the endpoint device
> > > > > firmware to properly reset the state machine. Because, if the refclk is
> > > > > cutoff immediately along with PERST#, access to device specific registers
> > > > > within the endpoint will result in a firmware crash.
> > 
> > Does "PERST# getting disabled" mean PERST# is asserted or deasserted?
> > 
> 
> PERST# assertion I meant. Will change the wording.
> 
> > > > > To address this issue, let's call qcom_pcie_host_deinit() inside the
> > > > > shutdown callback, that asserts PERST# and then cuts off the refclk with a
> > > > > delay of 1ms, thus allowing the endpoint device firmware to properly
> > > > > cleanup the state machine.
> > 
> > This *adds* the qcom_pcie_shutdown() callback, right?
> > 
> 
> Yeah. Will make it explicit.
> 
> > > > I guess this 1ms delay is the PERST_DELAY_US hidden inside
> > > > qcom_ep_reset_assert()?  I assume the refclk disable is done by
> > > > clk_bulk_disable_unprepare()?
> > > 
> > > Yes to both.
> > > 
> > > >   #define PERST_DELAY_US 1000
> > > > 
> > > >   qcom_pcie_shutdown
> > > >     qcom_pcie_host_deinit
> > > >       qcom_ep_reset_assert
> > > >         gpiod_set_value_cansleep(pcie->reset, 1);
> > > >         usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);  <--
> > > >       phy_power_off(pcie->phy)
> > > >       pcie->cfg->ops->deinit()
> > > >         qcom_pcie_deinit_...
> > > >           clk_bulk_disable_unprepare                         <--
> > > > 
> > > > Is there a spec citation for this delay requirement?  If not, how do
> > > > we know 1ms is enough for whatever the firmware needs to do?
> > > 
> > > Both PCIe base spec and Electromechanical spec only mentions Tperst,
> > > which is the minimum time PERST# should remain asserted. But there
> > > is no mention about the time, refclk should be active.
> > 
> > I see Tperst mentioned in PCIe r6.0, sec 6.6.1, but AFAICS the value
> > is only defined in PCIe CEM (r5.0, sec 2.9.2), which says 100us, and
> > maybe other form factor specs.
> > 
> 
> I'm not 100% sure that Tperst represents the minimum time to keep refclk active.
> 
> > If PERST_DELAY_US is enforcing Tperst, why is it 1000us instead of
> > 100us?
> > 
> 
> As I said above, I'm not sure if PERST_DELAY_US corresponds to Tperst. It
> predates my work on this driver, but I'll check internally.
> 

Ok, got the answer. This delay indeed corresponds to Tperst, but on Qcom
platforms this delay was found to be not enough. So they increased it to 1000us.
This shouldn't be an issue since PCIe spec mandates only minimum delay.

But regarding the refclk active time, spec doesn't mandate any minimum time. And
as I mentioned before, it could be due to not caring about the usecase.

- Mani

> > > So I used the existing delay post PERST# assert in the driver. I do
> > > not know if that is enough for all the endpoints out in the wild,
> > > but atleast satisfies the requirement of the endpoint I'm working on
> > > (which is another Qcom SoC in EP mode).
> > > 
> > > We can change the delay if someone reports any issue with the
> > > existing one.  Atleast, that's the best we could do in this
> > > situation.
> > 
> > I'm dubious about this.  If endpoints require a delay here to work
> > properly, the spec should specify a minimum delay.  We can't make a
> > reliable system based on "here's a guess and we'll update it if people
> > report issues."  That makes me think this endpoint mode Qcom SoC
> > dependency on a delay might itself be non spec-compliant.
> > 
> 
> I wouldn't say "non spec compliant", but a usecase not addressed properly in the
> spec. This Chip to Chip usecase (connecting two SoCs over PCIe bus where one
> acting as host and another as endpoint with their own power supply), is not very
> popular IMO.
> 
> - Mani
> 
> > > > Do other drivers require similar changes?
> > > 
> > > Most likely yes, but that also depends on when the drivers are
> > > cutting off the refclk. Not all drivers are implementing the
> > > shutdown callback, and even few of the ones implementing, do not
> > > assert PERST# since it is optional.
> > 
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index 2ce2a3bd932b..41434bc4761a 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -1618,6 +1618,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static void qcom_pcie_shutdown(struct platform_device *pdev)
> > > > > +{
> > > > > +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> > > > > +
> > > > > +	qcom_pcie_host_deinit(&pcie->pci->pp);
> > > > > +}
> > > > > +
> > > > >  static const struct of_device_id qcom_pcie_match[] = {
> > > > >  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > > > >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > > > > @@ -1670,5 +1677,6 @@ static struct platform_driver qcom_pcie_driver = {
> > > > >  		.pm = &qcom_pcie_pm_ops,
> > > > >  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > > > >  	},
> > > > > +	.shutdown = qcom_pcie_shutdown,
> > > > >  };
> > > > >  builtin_platform_driver(qcom_pcie_driver);
> > > > > 
> > > > > ---
> > > > > base-commit: 51459eb30f88651d3688b9e95fed0f97767ececb
> > > > > change-id: 20240313-pci-qcom-shutdown-d86298186560
> > > > > 
> > > > > Best regards,
> > > > > -- 
> > > > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

