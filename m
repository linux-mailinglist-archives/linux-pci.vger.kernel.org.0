Return-Path: <linux-pci+bounces-16067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7029BD3AA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 18:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F741F21BD2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E111E3786;
	Tue,  5 Nov 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k24AvR5o"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4781DD0CB;
	Tue,  5 Nov 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828680; cv=none; b=DqaHViXEpvOitWmW+xZLb5+6H6bFfDEbBsb3JUU+ziLshTVxeuTFt9nH1Bcq29aqxnl+YFa8Pd6q21e1nFYIWrq2ydSoZEX86XBf3nb/PDvtXiAnDLVmeLv989uNtQbowcKT+X+S3t6DjN9n3hv8SnYxjHuA45jQ0BvY35pbcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828680; c=relaxed/simple;
	bh=llA+9A1gl8QsLp3YRm0QnpwmV8v5h7ScdeMLoZBWCdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pphmcg+m+gfPZ9goHfw3KZlLbcOXB65RGbHCdEOzA4gK7WfuUj+agos8ItSASsKsXO4Lq+svANydmYfXa2FExPRB6nin9XUwFfC5/8nw2xcSYMjRO670PlqoJM6a5ivw0OsGtI8zEju0dpCZ1ZnlnGPYNTOABHCHSYrtsHAPS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k24AvR5o; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DBF220003;
	Tue,  5 Nov 2024 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730828676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Qhl7sCE20XQrZDR2W9BC9svI9gvOmt7VBMnt9ZYunY=;
	b=k24AvR5oTKNdMLhPSg/xgaiY9RqcLmBXVldHKvWfTRrnwRDt8bBRt0/QMGD6vTl0ERLQyF
	0/XIBN/71IjnJKEHdnnigQniikUm3fdq3oE3My6MV5INRIcyqwY28RkP+t+oF6gevA+Sel
	y7kfofyqRaOrOVfZrf5HOGHOtjmYqYrgEhS6svTadiLSAdGWkNQE1ZP+0I+TS4dgHnrm/n
	+UszIyPvO0FM8FkTvdbGizsLzqTFz+c5Ht4LZiwa4cYAs2Plsq+yWR101O6Bl3ggf8Tunh
	bwjmtzIaNmYiANuifngRIezuoa+RDKiXpwSTognVV1DwMLcDLSGtZKc25U9XYA==
Date: Tue, 5 Nov 2024 18:44:33 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/6] Add support for the root PCI bus device-tree node
 creation.
Message-ID: <20241105184433.1798fe55@bootlin.com>
In-Reply-To: <20241104201507.GA361448-robh@kernel.org>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
	<20241104201507.GA361448-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Rob,

On Mon, 4 Nov 2024 14:15:07 -0600
Rob Herring <robh@kernel.org> wrote:

...
> > With those modifications, the LAN966x PCI device is working on x86 systems.  
> 
> That's nice, but I don't have a LAN966x device nor do I want one. We 
> already have the QEMU PCI test device working with the existing PCI 
> support. Please ensure this series works with it as well.
> 

I will check.

Can you confirm that you are talking about this test:
  https://elixir.bootlin.com/linux/v6.12-rc6/source/drivers/of/unittest.c#L4188

The test needs QEMU with a specific setup and I found this entry point:
  https://lore.kernel.org/all/fa208013-7bf8-80fc-2732-814f380cebf9@amd.com/

Do you have an "official" QEMU setup on your side to run the test or any
other pointers related to the QEMU command/setup you use?

Best regards,
Hervé

