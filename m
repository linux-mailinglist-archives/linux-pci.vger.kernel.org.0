Return-Path: <linux-pci+bounces-14177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE42998259
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 11:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0FA287C1E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6731BD50C;
	Thu, 10 Oct 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En4Ag8Dl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5F33CE8;
	Thu, 10 Oct 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552823; cv=none; b=CYYd1BIKZnxv9TE08PkTGE55vV8BUoVwiYfbr8yv+9UzkyhGEgTtUcH7zBNO/lxgG6zatF0otNQ07h8DLF3YKGOfAFNh01rgtak/iSuJJj6pDoQNIwIC2Zt5JIcyKdqDgg2gZPU5nxwQIQHdL6FhkX8VP9Nq0JcAvOpXU3iWvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552823; c=relaxed/simple;
	bh=qBxQgkj2nJgxxaoqA5Dg7eRIG8Bdg50/61evn+NoLJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+j8BPIjv/Cnkn2BGioDuX+GeHP0jLy2+0J7wSyo2SMPmQvTznMhbvmgNHSwRWKCamPaHosDgxMUF32HkVPXXqn/y4i4E4zZzu+b9ffuSLYF9e03GyTOno2kar3u0D/Fsj8iU6/OsHMmpvvpeGpqqYnPzp7VlcB345D0NOxszt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En4Ag8Dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2F6C4CEC5;
	Thu, 10 Oct 2024 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728552823;
	bh=qBxQgkj2nJgxxaoqA5Dg7eRIG8Bdg50/61evn+NoLJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=En4Ag8DlmZ6disIgz53CZ3K0DvRM+gC92oLowhIX/DCCQXVFmeO6m4HrbmW9EVIlI
	 xg05COwRn39bwJ2LXUzaWIbjQEiTZOeOXSmn4a0cS3vBNjAbMt33NhE4N0hsALnhlX
	 e/SI9T38sDZcPnQiF+RyM/kZ7yMtfyfsZfcbeHNJPoj8VdEnQR3Rr/poUtbNQcT7tr
	 UgvL7v2VWhkRVwojxQIlQDbLqiGpenIc4MOyhx6BtyUKjSeLi0Q8hoReD/rBuHXB07
	 xCHtIVAws4xHmZm19B6Y+dREdmOmj+YYrJcSf0tRCyAto27CKikNGxPu7WZyZ2dYMj
	 kUkvEVnOms8uQ==
Date: Thu, 10 Oct 2024 11:33:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <ZwefciwGBSU-iwFg@ryzen.lan>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
 <ZwaagtTx1ar1CW4V@ryzen.lan>
 <AS8PR04MB8676516366FB6EE23F4823C68C782@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676516366FB6EE23F4823C68C782@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Thu, Oct 10, 2024 at 02:17:25AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Niklas Cassel <cassel@kernel.org>
> > Sent: 2024年10月9日 23:00
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; l.stach@pengutronix.de; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; imx@lists.linux.dev
> > Subject: Re: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
> > "atu" for i.MX8M PCIe Endpoint
> > 
> > On Tue, Aug 13, 2024 at 03:42:20PM +0800, Richard Zhu wrote:
> > > Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
> > >
> > > For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the
> > > driver. This method is not good.
> > >
> > > In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
> > > Frank suggests to fetch the dbi2 and atu from DT directly. This commit
> > > is preparation to do that for i.MX8M PCIe EP.
> > >
> > > These changes wouldn't break driver function. When "dbi2" and "atu"
> > > properties are present, i.MX PCIe driver would fetch the according
> > > base addresses from DT directly. If only two reg properties are
> > > provided, i.MX PCIe driver would fall back to the old method.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13
> > > +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > index a06f75df8458..84ca12e8b25b 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > @@ -65,12 +65,14 @@ allOf:
> > >      then:
> > >        properties:
> > >          reg:
> > > -          minItems: 2
> > > -          maxItems: 2
> > > +          minItems: 4
> > > +          maxItems: 4
> > 
> > Now it seems like this patch has already been picked up, but how is this not
> > breaking DT backwards compatibility?
> > 
> > You are here increasing minItems, which means that an older DT should now fail
> > to validate using the new schema?
> > 
> > I thought that it was only acceptable to add new optional properties after the
> > DT binding has been accepted.
> > 
> > What am I missing?
> > 
> > 
> > If the specific compatible isn't used by any DTS in a released kernel, then I think
> > that the commit log should have clearly stated so, and explained that that is the
> > reason why it is okay to break DT backwards compatibility.
> > 
> Hi Niklas:
> Thanks for your comments and concerns.
> Up to now, the pcie_ep of i.MX8MP is only present in i.mx8mp.dtsi file.
> And it isn't used by any DTS in the release kernels.
> So, this series wouldn't break DT backwards compatibility.

Ok, this information should have been in the commit message IMO.
(Too late now, but for the next patch affecting i.mx8mp.dtsi)

In the normal case, someone reviewing a DT binding patch will of course
assume there thre is actually a DTS using the binding, thus in the
(non-normal) case where there is no DTS using the binding, I think that
you should explicitly mention that in the commit message.


Kind regards,
Niklas

