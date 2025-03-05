Return-Path: <linux-pci+bounces-22934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758F6A4F64E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC03A9C60
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7C71C84CC;
	Wed,  5 Mar 2025 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcrP/nzk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD41386B4;
	Wed,  5 Mar 2025 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151426; cv=none; b=NiZTkrf+zizBD+YzyCrnwHxaV9w4B4ebnsC/yp8Av9Ob+OySPQpg18y2O1HDJfDa2/dqwzx20UrPtivvEi9+vGnyI5cS4w903UiPXDkYSRt72i3Yq3TfnDWmeYvp0wcnQU+8D5MtHULV7/vkmHIIAzo0aDYstqlMJ2x360KyRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151426; c=relaxed/simple;
	bh=p2cw06SZdXu8fyNDhTYJkpK63ATQR1w191Nw7/Rk8qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR8+B7VcEtZlOkDq/AZaAHhYzByGrZUpL0iGrdM+Ygx7mXX5q/yHj4y9yw3vKAJI6IHpS28LXQMfNHC8g26XpUfYjmwIfjKqmgaDsXsQs2PE3x5soPN3lrIlRjbWoCplDrGnLTAATaM55tbRSppWzawnipsIDuqF4cw6G8FpPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcrP/nzk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471fe5e0a80so58097561cf.1;
        Tue, 04 Mar 2025 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741151424; x=1741756224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4aXc+eFaQqactfAjsWukq5bexYGgg4h92obG4bg34aA=;
        b=QcrP/nzkYGkGNJzauHHF0lXcLm9JC0r1lQU/PBLaFWmJH9u6diuLxZVDTGWww1AbVD
         IEmE+JL8ys6h1cqjBxLuaJ+tJ+Cto5r6LlNjaRakt7f8Fulk28cGFIXhJlLDmZcIl9df
         yuUg4/KiPAqx+DdoNcD9+3Bsl/WiIVpBtgNvDxR1dfbLQ1/EILNpp0G3qjdC61ztOv7a
         /AYCC9Fi5kfaSBSpOx60zo33C1PPyb9QjUlbleVuA8VTFt0Ecp3o4/7WwTJ9cIdIzqkH
         fUi7CDXzLxymnpNSyvfVhlsAtK3uBokQS6brapq0ufkxCiSNJRQTYm4LO3f7af7QqnV5
         Fb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741151424; x=1741756224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aXc+eFaQqactfAjsWukq5bexYGgg4h92obG4bg34aA=;
        b=WxXdZSKg+bYFQqRzl+pr6k2XpD6BV7WaSv/tF/KdE2VBqwYoZer1winwB+w5x242e/
         BcWhA/Ddq9jSdtkTu5iiok4L0JBA2w7KhsZC/4wuFeqfzqowZtneTZFu5QB+9/ibTtOs
         JNnLRNd1zKTFnxKiVytQgb1a0gLdbQM7mZ7fpyiozzldmzfDlr6KAoNDnyDrwxlfj1Dt
         SzzKSH7hX9EnpXhgUF79AqHsCUwUIk3zwkL0iDilQBIkX+og5C7nchVOeo1sDbGUysdH
         eLdtX24h+YGzvugNzFbubQh8WKlFieW2Mrylcxpztj3YM8BeXfV0UxNiaK55duXw4KWG
         sp4g==
X-Forwarded-Encrypted: i=1; AJvYcCUwndPDrlFZJ3bv6GcJQ+v8W/5C1aaTClGx6zeVKYxGq2StxhAe9Tjhe7pURo+CvCmZSER9Qtaeu7gL@vger.kernel.org, AJvYcCUyBoeK4N4/nwMAPSt1egqKW7l4jwwfA+LqW83b0bnxi2zlsYC3g4VUTvI5RDehx+VLdf71RHtbZcYV@vger.kernel.org, AJvYcCWaProX3WTw8xiDssW2hT0XnRCBxp8T7mVWiIR1GyiYdn2hM/WEhFFK+x/FbOXfKHdk1eSVbsz8aTyprG29@vger.kernel.org
X-Gm-Message-State: AOJu0YwymimX/cBKg4h5qntPaGVWID4g4JeMfXruTjdE176V6iPXuwVz
	+cWLpqHGviBKOX+wCdqzrPk+hlTAUKRXComaOqnarTGTpEVE9mss
X-Gm-Gg: ASbGncvkO0ulVrYisn1UXT6zkFIKyKERxyLsjRLkf6HgLHUwfqfZwecgqq9yunHuPj7
	74vRash+QGZ+lFnBBtAS1ii2OldUTN/35YUQjUTgfZd3Quv4Wflp60hlm/PFmcBcKr1Lzr3K7Gg
	xEj4Bk+Oqj0rIWHCmMyENTCrieDIY9ioTUUT4rsDreeRo5YJrU36h7KIB9OvHqu5dnTq20Z7HRL
	lKOh4wlP6ZF5GWWX7Yflix9bd1N31Ch+JlPpLT20JS0RTVNEAgjILj9MuGNg5IxXEy2aj3tHwbF
	f4A4dqeIc2xoRe2UFui9
X-Google-Smtp-Source: AGHT+IHU4vogNMuRCH0tVBz2RJOUF3BRl3lUNyiWVLGC65w1tNpBCw5qZt0mtmykFYE9WEb3N6Pl9g==
X-Received: by 2002:ac8:584d:0:b0:472:447:ad7d with SMTP id d75a77b69052e-4750b4c3f0amr21880881cf.32.1741151423766;
        Tue, 04 Mar 2025 21:10:23 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47508cfc40fsm9857171cf.34.2025.03.04.21.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:10:22 -0800 (PST)
Date: Wed, 5 Mar 2025 13:09:55 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Johan Hovold <johan+linaro@kernel.org>, Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Message-ID: <bxwsvluj6amgoelk7r55gqhmhjwpewnfyhvvw6zpxen7kqzvwc@fxcebjzo5axk>
References: <20250304071239.352486-3-inochiama@gmail.com>
 <20250304173632.GA243820@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304173632.GA243820@bhelgaas>

On Tue, Mar 04, 2025 at 11:36:32AM -0600, Bjorn Helgaas wrote:
> On Tue, Mar 04, 2025 at 03:12:38PM +0800, Inochi Amaoto wrote:
> > Add support for DesignWare-based PCIe controller in SG2044 SoC.
> 
> > +static void sophgo_intx_irq_eoi(struct irq_data *d)
> > +{
> > +}
> 
> The empty .irq_eoi() is unusual.  Why do you need it?
> 
> I see that the existence of chip->irq_eoi() makes a difference in
> chained_irq_enter() and chained_irq_exit(), but I'm surprised that
> this is the only driver in drivers/pci/controller/ that implements an
> empty .irq_eoi().
> 
> A comment here about what is special would be helpful.
> 

It is more like a mistake that from the vendor code
that I refer to it. This should be a level irq, and
I haven't tested it as I does not have a device use 
INTx. I try to get a test device will replace this 
empty eoi with handle_level_irq if I can confirm it.

Thanks for pointing to this.

Regards,
Inochi

