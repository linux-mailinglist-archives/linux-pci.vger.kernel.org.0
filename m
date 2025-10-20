Return-Path: <linux-pci+bounces-38723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B821BF0B96
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18583B4892
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8EF2E8B98;
	Mon, 20 Oct 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdL9heF/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D94253F39
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958251; cv=none; b=JNqikfCMFUCqJdN6LRItTMtXxPhNTvDEO0g87IWe/16DCYTRx3uf8+W4mRA5dnRGpSrpCjKP3fejesCrh1nCLjMnOWnCBf8WtryKshD/wDcjqB1KGAuMUOhDqcbQaNG2jW0Bwak715blf0nHsAgXbuj41Nlz0E/t751J9X5qYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958251; c=relaxed/simple;
	bh=0LNVKhKYvOfzeoMYGReCyEwIb7Zs223HMIrQWreAmBM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss+vBrgLE+8SEvw4sl0VknAUVKLQHfc0DRRqOgDyNEwqOPQNJ6AD+dquXIKiCiIu7t8Hvwj8RHNAfeRfZXVBu0JPe/Ju9nghiaZUgnTnNyG+jp2OUL+ndHoKzFiSD0p7WfXPxIBZbpWpQmK6XBCJ3LwWISHzMg+H6AUaO5yK6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdL9heF/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47109187c32so19793575e9.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958247; x=1761563047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYOfZuoNHQ6zfb1eIHdQ/g7m/nIgJIBArSgWVNXdu3o=;
        b=BdL9heF/9RoWLaly4MIo/TZi90jEtDnWuV3fW2GwBtjDTGqCaironsSdTzpUyhzJu6
         YiYJ9jewGZ/zWG14il+lqoWrUm9m0tqyIFnzBagGGYaVPkSNcyARNp5dn6hOxiIA8EB1
         U6utXdZf44unXcuLPDSmog8ugi+giNXIjm5NF1PTJtUTVnATMUvevmLDWmd6obhXwf1x
         zQw/PPsyTO02u1QDlo9rtBBneZ9W2qGVMqNzcPy9B/NTnViTIXq18SV3swDLfqyAJa0g
         AfGqeuHB5f22KX8L2RFtE7eyjOeQcowWsSB57XHwfLQuyH+IZKl75jmIZg9yT+uguGg+
         6UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958247; x=1761563047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYOfZuoNHQ6zfb1eIHdQ/g7m/nIgJIBArSgWVNXdu3o=;
        b=CQUqHaC53Rhx2eQ6QOJzhAxfCgLq6lmssM5nCEtKrDE7tnsobkWn0pwIw5woSNxh2F
         k+CiXQnHTfImAP07ewHMflGB4/9VcZHRbfW2mBy11Eqd0xw5DDmv//ydkwVx16R+jlEz
         iTc0TlRQ/XtRdnLwrd3FFICrOc4Xa1OtjxqXhS8d/Ygylb/ypAq527tOsZGG0QQ0dGQe
         +6sIXIZzHeZDdbaI8+0LY65J/Y/IO1C/A3dRDAN1Wh4yvVfhIA5MSGb7DQSQu8SCi/uy
         1K6z1Mz02G86DOV6E6Fi11SY1+0F5Vpc+OZb7GA7H+Fx6+mm4NDhdsMVLugJz0y+z5xL
         hufQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJcno1IGM6vKq/kubZ2qdW6Ixo7kEYm0JGO0wlavm6EMgYAsXhiN+ONZIk09VYo8BQV6HuBl4k/qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzrGkqkI72NYtaflE2OhAGEj3NUGhIrdpJsCLPA1QEoyqaMSc
	GpPfXERKm/oq7fczIPXy9cpaAJdP+ZTlcQe5dakgElLPJmzn31C9NRw6
X-Gm-Gg: ASbGncsW9m+E+w6xN2AYG3PNeZyhCnF+24K4miOr4xx51Mtx0GTFa7jS/Pm/+ZlYIUJ
	RMYX4LdoLjr4xCMA7PM39LWRrf7IX/gCDbIy76SMfzUdKutprYNbVTNUiiWdhFZBrxNHDznU90p
	J6KRA6/TynCH92zFZx799i9NIw9GQZsWonzH9VafsGgIlCpUQCN5+x1XsmPts6eFtz5T+ah4COU
	zGf7RhIr0YYWKHYGXhE/ntw/YMPrrlL0+QVvhHCGSKuMtxMelYRqpDqTM+myDhTOtxfXlBoUhoK
	VIIDmi7nypaQOKAWA+SJEHp/WwJZtqD4dGjZumVsD7ur+RjorZWNTZkA+Goi6mB+muEDhESKbxA
	HcSOnB+pc/8zdlD/d6yN+/RdLiPW5wGOAAfu5FfX9VJpJVko6q9t/L/1hZG3vey/00nCzmVbe2/
	UX8z1jp6SsOfPCPjcM7XVJ/4KF8eeSaE73gqqhgFY00Q==
X-Google-Smtp-Source: AGHT+IGgJEIPMXEXNKI395DmJYirOVPGUv9eBwNI0mKNkT1iDHPejiG58osCYccM9drAAu3VR8kn5A==
X-Received: by 2002:a05:600c:34d5:b0:46f:b42e:e394 with SMTP id 5b1f17b1804b1-4711793473fmr92013195e9.41.1760958246642;
        Mon, 20 Oct 2025 04:04:06 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715520dd65sm137840795e9.15.2025.10.20.04.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:04:05 -0700 (PDT)
Message-ID: <68f61725.050a0220.343129.f1f0@mx.google.com>
X-Google-Original-Message-ID: <aPYXHZQYtY_jcRhd@Ansuel-XPS.>
Date: Mon, 20 Oct 2025 13:03:57 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v5 5/5] PCI: mediatek: add support for Airoha AN7583 SoC
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
 <20251012205900.5948-6-ansuelsmth@gmail.com>
 <hjyhso2sqgyq4ymzqg6pmjfrfncla24zwsev2mfinolmclm3ih@sol2yoapbykq>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hjyhso2sqgyq4ymzqg6pmjfrfncla24zwsev2mfinolmclm3ih@sol2yoapbykq>

On Sun, Oct 19, 2025 at 01:01:44PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Oct 12, 2025 at 10:56:59PM +0200, Christian Marangi wrote:
> > Add support for the second PCIe Root Complex present on Airoha AN7583
> > SoC.
> > 
> > This is based on the Mediatek Gen1/2 PCIe driver and similar to Gen3
> > also require workaround for the reset signals.
> > 
> > Introduce a new flag to skip having to reset signals and also introduce
> > some additional logic to configure the PBUS registers required for
> > Airoha SoC.
> > 
> > While at it, also add additional info on the PERST# Signal delay
> > comments and use dedicated macro.
> > 
> 
> This belongs to a separate patch which should come before this one.
> 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 92 ++++++++++++++++++++------
> >  1 file changed, 70 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 1678461e56d3..3340c005da4b 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -148,6 +148,7 @@ enum mtk_pcie_flags {
> >  	NO_MSI = BIT(2), /* Bridge has no MSI support, and relies on an
> >  			  * external block
> >  			  */
> > +	SKIP_PCIE_RSTB	= BIT(3), /* Skip calling RSTB bits on PCIe probe */
> >  };
> >  
> >  /**
> > @@ -684,28 +685,32 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  		regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
> >  	}
> >  
> > -	/* Assert all reset signals */
> > -	writel(0, port->base + PCIE_RST_CTRL);
> > -
> > -	/*
> > -	 * Enable PCIe link down reset, if link status changed from link up to
> > -	 * link down, this will reset MAC control registers and configuration
> > -	 * space.
> > -	 */
> > -	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> > -
> > -	/*
> > -	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
> > -	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> > -	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
> > -	 */
> > -	msleep(100);
> > -
> > -	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> > -	val = readl(port->base + PCIE_RST_CTRL);
> > -	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> > -	       PCIE_MAC_SRSTB | PCIE_CRSTB;
> > -	writel(val, port->base + PCIE_RST_CTRL);
> > +	if (!(soc->flags & SKIP_PCIE_RSTB)) {
> > +		/* Assert all reset signals */
> > +		writel(0, port->base + PCIE_RST_CTRL);
> > +
> > +		/*
> > +		 * Enable PCIe link down reset, if link status changed from
> > +		 * link up to link down, this will reset MAC control registers
> > +		 * and configuration space.
> > +		 */
> > +		writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> > +
> > +		/*
> > +		 * Described in PCIe CEM specification revision 3.0 sections
> > +		 * 2.2 (PERST# Signal) and 2.2.1 (Initial Power-Up (G3 to S0)).
> > +		 *
> > +		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> > +		 * for the power and clock to become stable.
> 
> You can drop the comments since PCIE_T_PVPERL_MS definition has them.
> 
> > +		 */
> > +		msleep(PCIE_T_PVPERL_MS);
> > +
> > +		/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> > +		val = readl(port->base + PCIE_RST_CTRL);
> > +		val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> > +		       PCIE_MAC_SRSTB | PCIE_CRSTB;
> > +		writel(val, port->base + PCIE_RST_CTRL);
> 
> If PCIE_LINKDOWN_RST_EN corresponds to PERST# signal, then it should be
> deasserted only after the power and REFCLK are stable. But I'm not sure what the
> above PCIE_RST_CTRL setting is doing. If it somehow affects either power or
> REFCLK, then it should come before PCIE_LINKDOWN_RST_EN.
>

Hi I checked MT7622 programming guide for this.

The order of operation for reset is exactly what you have described.

Indded, first everything is reset (assert all signals) then we set
PCIE_LINKDOWN_RST_EN that in unrelated. We wait for clock stabilization
with the msleep and only AFTER we deassert the PCIE_PERSTB.

So no, PCIE_LINKDOWN_RST_EN is not PERST# signal sw but it's actually
PCIE_PERSTB.

> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel

