Return-Path: <linux-pci+bounces-34764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20B5B36F1B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F3E7AE88E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E91731A55F;
	Tue, 26 Aug 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es+EKWJl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D331A553;
	Tue, 26 Aug 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223850; cv=none; b=EdFBDMnaw28csy8Rl+CrftOBqnQ33BFT9jxkJ1c32/BZTXsCCGjBuFZWsRHc5xObledGbJ0sDnyOyx9PGMViO0x8piggytTjD5QkTTGh7RWkYHdEGA43O4Mzvko0kUoOYQ354i1DuU/SZI6lJp45z/a4p+aBQNLnlH+cTRxDo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223850; c=relaxed/simple;
	bh=dWfTpcbs61ZTxm2zLQag0c0aVNnadbzW6WKlvfxG4MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNtaT2yuYFw/zhes+LE27+8DW/damXrvMIfuoUec5EVlYHrMpUdDN/OTj8tMzs5tKV1YtVBEn7fRLRMJ4EXr7gaRkfuWCv3by9OdVtQbz9ANgLihX7dRsx9zHPoW1Jeug2/RmBfAasmgFQgcDdxlyrPFQlAxNA+QxHqGCpcHgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es+EKWJl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb72d51dcso794922666b.0;
        Tue, 26 Aug 2025 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756223847; x=1756828647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q16dKHlTwpYrrj7j3XR8iGEG885KppKpi9YethFwuUM=;
        b=es+EKWJlQkClO/bCZQ60y65Xwr0aBFae07EXCWxrP6okuqt9tNq0mXb/oPTjpWGyrk
         IesbJRlvs9XG4HV0FRkLDQE5d5g7EUgmgOFGD8Som54w4tQ34AzFjQBW3VMVEE9yDZ9O
         YicGLvUzo7lvFMEIpyESP48OZUX2Hf9wrOBn2HikQe0qslM1sEmQE2vd1KUs+Ul0zfj2
         ZtuS6HAydboJL15ryz1dMlc5nL9QJAG62fYkxcjRk+v1RH5PajP5YjviMzvqDeomAgVl
         nHtw64U+WsF15mcLwaPAhZndaKp9bYe8s29cnTteQEngomd8pTUxlI3hUOfsosjrzGes
         PuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756223847; x=1756828647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q16dKHlTwpYrrj7j3XR8iGEG885KppKpi9YethFwuUM=;
        b=cjtK1Pb7GA/aHtRHumAjKvYgNNdF4hHWkibuNV8bsSZhPRxGC+AiL7SsiO24lUSeai
         HlfWp5rn1mbWvjJ5dj+5cHgS/Q4SNsshD6wZUJHglodS3jetjlOAT0+G5QGAFWdJ7rhg
         vkJW69dUzy7mkpZ2ew3jGsYLrMbuI0LgFSqO+UIPKB33KVhpRZkqEtSGjpmBoOfliNdP
         KPjD/oho1Q17vvNmPUR9A+MLl+fJgp5pJ72Gc1y9Lx4ycVkaCaaK2eRlEZRtFuxhMcU9
         XUxnXuz0HSKeqYaZa0MqXJGYGpXmidOsfixQFpC+yIGA2dDc/J6/vh7pulHhDsQAB8iH
         oMUw==
X-Forwarded-Encrypted: i=1; AJvYcCUkXVc/MLCSS2gbwGtw+B0uTkOcV0R1QQGY6znkaH0HKQiO/gz+Ltat//Q1uY1gVMoQ6vumZPRJpME+@vger.kernel.org, AJvYcCV1y388YN4y658EDXtxuTJqml7Z0laxwA7xi/IZkfJMAU3UJ0zXxBEntjwuAFIXfl8BjlyBrw3NcpQrgWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmoD5fSwxcAnfRqrTPwyLmS2dnj4QUdGj1o9EuwCE4QkTzLY8
	b2YNL7UGk1sVUcTwU+/4MkR+CVm1INZXsRO882UO3fAaMJzHyV4K03J0emNzNy4hHJzpqN36ezl
	hEhhSbrFEDvsy40XRQsxmER/oBnbfQu+Y8w==
X-Gm-Gg: ASbGncvQsWsYDN4EpjM3gpqieK4qpprzzcg4PTPPAZ4Qz3/C1uWkaRXUo1LXq2YlxsW
	nINcZNOd0Qi7stkpQFbpCYYXEdQOdZmoIz6JBFdu/PS8rOy5QrEMW/MwBU1Zc02VV09oelw07CH
	JXVrUcm0FSZlHsiAxxyXJXxAbQ0ps9gLva308xxcdzXiCFM2R0atJMFffPS2Gjuk3Fmw7uWRvdp
	UTWVQ==
X-Google-Smtp-Source: AGHT+IFZTqxi5k2qS8wBNJ9LxXHZYVQVV8S6FHf87evoJqX3AEZ6ymflppv4sYqrKLOF0Hvfg9tEoo4CwVD1+Qpuyq4=
X-Received: by 2002:a17:907:6e92:b0:ae3:53b3:b67d with SMTP id
 a640c23a62f3a-afe28ec572cmr1413512166b.1.1756223846493; Tue, 26 Aug 2025
 08:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826114245.112472-1-linux.amoon@gmail.com>
 <20250826114245.112472-3-linux.amoon@gmail.com> <b3a9e4aa400cc03bcdc0e8d5dcd4ae82cacada86.camel@pengutronix.de>
In-Reply-To: <b3a9e4aa400cc03bcdc0e8d5dcd4ae82cacada86.camel@pengutronix.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 26 Aug 2025 21:27:08 +0530
X-Gm-Features: Ac12FXzOvXaYedsWjghmIb0jZtmmZTFRNVKhLzQ1XC-NnfTchF92NdkIBPO4_as
Message-ID: <CANAwSgQrtgL3k7gMvDmuJ-JHCozhJ_cHDXmKoA6oXVAuoaiM5Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: dwc: histb: Simplify reset control handling
 by using reset_control_bulk*() function
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCIE DRIVER FOR HISILICON STB" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Philipp,

Thanks for your review comments.
On Tue, 26 Aug 2025 at 18:16, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Di, 2025-08-26 at 17:12 +0530, Anand Moon wrote:
> > Currently, the driver acquires and asserts/deasserts the resets
> > individually thereby making the driver complex to read.
> >
> > This can be simplified by using the reset_control_bulk() APIs.
> >
> > Use devm_reset_control_bulk_get_exclusive() API to acquire all the resets
> > and use reset_control_bulk_{assert/deassert}() APIs to assert/deassert them
> > in bulk.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-histb.c | 57 ++++++++++++-------------
> >  1 file changed, 28 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> > index 4022349e85d2..4ba5c9af63a0 100644
> > --- a/drivers/pci/controller/dwc/pcie-histb.c
> > +++ b/drivers/pci/controller/dwc/pcie-histb.c
> > @@ -49,14 +49,20 @@
> >  #define PCIE_LTSSM_STATE_MASK                GENMASK(5, 0)
> >  #define PCIE_LTSSM_STATE_ACTIVE              0x11
> >
> > +#define PCIE_HISTB_NUM_RESETS   ARRAY_SIZE(histb_pci_rsts)
> > +
> > +static const char * const histb_pci_rsts[] = {
> > +     "soft",
> > +     "sys",
> > +     "bus",
> > +};
> > +
> [...]
> > @@ -236,14 +241,19 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
> >               goto reg_dis;
> >       }
> >
> > -     reset_control_assert(hipcie->soft_reset);
> > -     reset_control_deassert(hipcie->soft_reset);
> > -
> > -     reset_control_assert(hipcie->sys_reset);
> > -     reset_control_deassert(hipcie->sys_reset);
> > +     ret = reset_control_bulk_assert(PCIE_HISTB_NUM_RESETS,
> > +                                     hipcie->reset);
> > +     if (ret) {
> > +             dev_err(dev, "Couldn't assert reset %d\n", ret);
> > +             goto reg_dis;
> > +     }
> >
> > -     reset_control_assert(hipcie->bus_reset);
> > -     reset_control_deassert(hipcie->bus_reset);
> > +     ret = reset_control_bulk_deassert(PCIE_HISTB_NUM_RESETS,
>
> Note that this changes the order of assertion/deassertion, not only
> because resets lines are now switched in bulk, but also because
> reset_control_bulk_deassert() deasserts the reset lines in reverse
> order. So this does
>
> If the three resets are independent and order doesn't matter,
>
I followed the expected reset flow as part of the initialization probe process.
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> regards
> Philipp
Thanks
-Anand

