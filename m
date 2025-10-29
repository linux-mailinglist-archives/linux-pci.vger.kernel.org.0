Return-Path: <linux-pci+bounces-39600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB11C18819
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 07:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAC86563B2C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 06:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058D28688E;
	Wed, 29 Oct 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2v0awYy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503713FEE
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719398; cv=none; b=D9skGJqQrOuhUSoXMutoAZVj26bhPDLG7MyD2Uq13ILLlHWdsmxOGl1TK/6GoEXD1bcLN/N6lDi380B4wuFOeh9pd5vZtFuED3TCFXgH+uuN9hfp2MtoCBqfnrim1lFdBdvMeYR3o8Vfzy+TumYZ8qxAJj6fMjaO3iXoIIGYkHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719398; c=relaxed/simple;
	bh=kicBV7oIuS5DOwkjSIlCZ9hu2/48zXNrTZNbiv8Kemk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlilbQenFPgfH8aAt9WSb6EUFfLY/nSA8BWB3IM8ALPpzmWoobge8b/t1s70ZrpaLVtYoWD/RqGTiYw+84zd12ZulMdqIhjT/PEKaSWsCZTdbA63wYoXEqK9heP4AnEoAQRY263Igg3ewnfDBC5kaDHLa1HBmr8JVfgX5/uFDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2v0awYy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso12444574a12.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761719395; x=1762324195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uMONH+8GVOxyEjApROS3jg17q6oAv/cnPEMuimC2yEw=;
        b=Z2v0awYyw58Jtve/dcpJqh0rgNk/vH2V9iUFa+cjuSMULYPHwXYNvh7RzS/1wp8BZf
         4rZ78d12XvJywPZz1fyG3TnkhVkFEDNilqdKemF4gIg57FCIXIO7Hq/LC7GdL9/e7Pdk
         g4n/Ax8JMKeR3TKBkOZ55anskR+Bd9rc+ZPfBrIJ6300ndA/gX7ORAV0sHaMcLQhl0oV
         UCPb07N7br1/ymkVmC9AhEvjWA8ynySCezff9Y0wBqD4fIRyrD3m2jpK4rc+kl0/IOor
         85zXm9aEz9+8UPk2x19p7ZLBu0bq76rROeFxeYPK6xSbV2pZcVxANhh/fA/Mdqz2Dli6
         hMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761719395; x=1762324195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMONH+8GVOxyEjApROS3jg17q6oAv/cnPEMuimC2yEw=;
        b=PpHeVhoNvWyYmv+1gGlLYMXo/ti+TqxTGVrNJ51A216yB83H8T4TvKS9KE6TPMOWL7
         MOMJTOizulN2Jhx07m5s70LDdY3XTJyDnwBp8XDBo9cPUj4PYPDiRz8nkV9aZEymDgcF
         FOMWkQw0AQr5sWCtPJ+MhYqKdiSq7OM4Ov77AHOZlXNlk/tHgbI3nzn5a3jq0cD1+Tz/
         oSIVde6Nh7rtNasLDtCQ+czJw2JTQqMidPtpn0qM0DaZCEmJKMglbwmgxMmcp1nfhPgC
         KfJnvYLd2eb9vFD8sOKIR11RwAO8PA1eOaz1eMw9aIELWgTfUEBvWZZWKCZ/J0e7GKJa
         n6cg==
X-Forwarded-Encrypted: i=1; AJvYcCVJgrlDw+FXRj4Fv+EgQZ2kL2JCKUMmEYMp9flfkHHFxnJPoX7FCtZBRilomsJ0jvXpfdPjBh65euk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws2K5OXEOOuEr9uGrg1mZcTF+7/pfWCPNcpqwDZ1EZMkZI0eHU
	qLopUKrhnGsULABcpi2eY6HDsFAfOJbIwoJbWPrZ9q4dfBHJhSNk4HcDB+IQXMSqcC488VZ/k/k
	7d1wSZtVpEVaHrZ004E5jqlKge+Br1ZXI3Q==
X-Gm-Gg: ASbGncsfKXmAliB7rkBR9nxczyvKbkMm5jDQFaO1RIYe4wyVz1sFoHQv7fJWlYcijXB
	S5h1rIXd15+YnsuqFtvO7PqRFgMqe2ayaizQAZcBwOUYlPceeoRrCz+odVaLkaMsqV3Py8eDpAe
	2q7GlUxdeVsSClFOzHAXkQugGEcm+brignOgh//vJV0/lKa8dReGckw4NuIP5/Dq7/R89xsMN2Q
	vYnFZanx55vOAlx5IBoDYKUwYzf7gXeBdbwLDvQW+VeAOIzylxz2AviKgqcRpAbd+66Gw==
X-Google-Smtp-Source: AGHT+IGkpMP2JV93jKtrqYcUv2doQVUVgTWnNctMEjS6Xs0nmKSaC8SY+NE+YO+7RTCK8H8Slnh23fd4/D0WvABiTU8=
X-Received: by 2002:a05:6402:26d3:b0:63c:1f3e:6462 with SMTP id
 4fb4d7f45d1cf-64044251e38mr1273131a12.23.1761719394933; Tue, 28 Oct 2025
 23:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027145602.199154-1-linux.amoon@gmail.com> <5264377.31r3eYUQgx@workhorse>
In-Reply-To: <5264377.31r3eYUQgx@workhorse>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 29 Oct 2025 11:59:38 +0530
X-Gm-Features: AWmQ_bkhkw-pZtArjJD2gcBzKDEhehQeURBZRDtuYYptEbI6fqoAKgnKeMTW7xw
Message-ID: <CANAwSgQts0B2Sq0V2psa53WzTLEdU-Z=jkqGkW1ESmvKf_6EyA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add runtime PM support to Rockchip DW PCIe driver
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Nicolas,

On Mon, 27 Oct 2025 at 20:37, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Monday, 27 October 2025 15:55:28 Central European Standard Time Anand Moon wrote:
> > Introduce runtime power management support in the Rockchip DesignWare PCIe
> > controller driver.  These changes allow the PCIe controller to suspend and
> > resume dynamically, improving power efficiency on supported platforms.
> >
> > Can Patch 1 can be backpoted to stable? It helps clean shutdown of PCIe.
>
> You can do this by adding a Fixes tag to your patch. In your case, it
> might be fixing whatever introduced the clk_bulk_prepare_enable, i.e.:
>
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
>
> This would be put above your Signed-off-by in the first patch, after
> the empty line.
>
> To generate fixes tags like this, I use the following pretty format
> in my .git/config:
>
>     [pretty]
>         fixes = Fixes: %h (\"%s\")
>
> I can then do `git log --pretty=fixes` to show commits formatted
> the right way. To find which commit to pick, `git blame` and
> some sleuthing are helpful.
>
> With this tag, stable bots can pick the commit into any release
> that the commit it fixes is in.
>
Thanks for your input.
I will leave this to the maintainers to decide on this.
> Kind regards,
> Nicolas Frattaroli
>
Thanks
-Anand

