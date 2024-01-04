Return-Path: <linux-pci+bounces-1659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833D823F40
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBBE283F54
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175E20B0B;
	Thu,  4 Jan 2024 10:07:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7A20DC7
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rLKdN-0001FW-3A; Thu, 04 Jan 2024 11:07:29 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rLKdL-000JzL-Dq; Thu, 04 Jan 2024 11:07:27 +0100
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rLKdL-00ACE9-AR; Thu, 04 Jan 2024 11:07:27 +0100
Date: Thu, 4 Jan 2024 11:07:27 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, hongxing.zhu@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
	helgaas@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	shawnguo@kernel.org, kw@linux.com, festevam@gmail.com,
	robh@kernel.org, linux-arm-kernel@lists.infradead.org,
	l.stach@pengutronix.de
Subject: Re: [PATCH v7 01/16] PCI: imx6: Simplify clock handling by using
 bulk_clk_*() function
Message-ID: <20240104100727.xtwn76lhp72ika7i@pengutronix.de>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-2-Frank.Li@nxp.com>
 <20240102084744.tyquwp6hkb36tfxg@pengutronix.de>
 <ZZWTIbjBJ/DdpUQi@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZWTIbjBJ/DdpUQi@lizhi-Precision-Tower-5810>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

On 24-01-03, Frank Li wrote:
> On Tue, Jan 02, 2024 at 09:47:44AM +0100, Marco Felsch wrote:
> > Hi Frank,
> > 
> > On 23-12-27, Frank Li wrote:
> > > Refactors the clock handling logic. Adds clk_names[] define in drvdata.
> > > Using clk_bulk*() api simplifies the code.
> > 
> > does this influence the clock enable/disable sequence ordering? Just
> > asking to avoid regressions on older platforms which may require some
> > sort of order (e.g. require clock-a before clock-b).
> 
> drvdata::clk_names is order of enble sequence. So far we have not found
> the problem.

Okay, thanks.

Regards,
  Marco

