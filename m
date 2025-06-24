Return-Path: <linux-pci+bounces-30518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD87AE6B84
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72D71C418CC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE692DAFC2;
	Tue, 24 Jun 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX667HMm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34F2DAFBD;
	Tue, 24 Jun 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778898; cv=none; b=HWywMPk3DKvbvZkMqjn6iNWyDSQj4WXLEa1etuCtRRfVarqeimwGvpuz4pjEya08sjXVkFLD1bDaMFyUA9Ymq+TNNCBHvkMwn/mD/SvwEY6JA6J9fZMk1OWiLxXMx7utRVjj24P1x/AWP+fW104a0Q98DL6ayIymQQTXSN711F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778898; c=relaxed/simple;
	bh=Pl3NFZyhrvklSpvN1eF/J9iEI8F8auASAYz/1jCX/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iNQZUZNBTZWkTikUfsmXM7B1zJU6Sd6XzaxYrVTpK3mt3510AXwTlE4WHsvcEd4vis8QHlZTw/ZB5IKXjc2OTJd5NkudvPWlu9yx1ClTAse0OKQvsbfnK9kwGy+XQjbeWkrLBwczuRi2ga8zWPgzK9Zu27BhFp6ub4ZZ4Yt/dkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX667HMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF9FC4CEE3;
	Tue, 24 Jun 2025 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750778896;
	bh=Pl3NFZyhrvklSpvN1eF/J9iEI8F8auASAYz/1jCX/eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aX667HMmD7Y51beRdU5f4Hd584kRCoEk7KvoexSEew+t+eRh1pj1fR9UYQkqZHZfh
	 fWZBuBKFpWbUuR18ZgET27bcKTR21VWtudD2h/MiJg6xbrWNzJmKi4wWdNJxp8UTpF
	 cLfLjNx7iOPtPZpUkfu58+hbZmJ888pu5bFPuQLLNe3jewq+aBRDEgJjvD7ycC26mJ
	 gerZK14v2YkZRrVmf2+j4+xZpI9yO8HqO8Rg7b5p731cuNj3lCL5h1fcWXBFxZrqNF
	 KCL0s7tmxxejQDhFnb583lC+8Fm9OWcJ3n4gkCCspwZLuTbTLsDNKxeUPWTTXNkXBe
	 /ynLZbIg6aNbg==
Date: Tue, 24 Jun 2025 10:28:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"elbadrym@google.com" <elbadrym@google.com>,
	"romlem@google.com" <romlem@google.com>,
	"anhphan@google.com" <anhphan@google.com>,
	"wak@google.com" <wak@google.com>,
	"yuxiaozhang@google.com" <yuxiaozhang@google.com>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH 5/7] ARM: dts:
 aspeed-g6: Add PCIe RC node
Message-ID: <20250624152814.GA1477818@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51343F38D4F9C130A4CE3FED9D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Jun 20, 2025 at 05:24:39AM +0000, Jacky Chou wrote:
> > > +				resets = <&syscon ASPEED_RESET_H2X>,
> > > +					 <&syscon ASPEED_RESET_PCIE_RC_O>;
> > > +				reset-names = "h2x", "perst";
> > 
> > PERST# is clearly a per-Root Port item since it's a signal on the
> > PCIe connector.  Can you separate this and any other per-Root Port
> > things into a Root Port stanza to leave open the possibility of
> > future hardware that supports multiple Root Ports in the RC?
> 
> The PCIe RC that designed by us is only one root port.

Yes.  But this driver may be used in the future for other RCs that
include more than one Root Port, and it would be good if that didn't
require structural changes to the DT.  Also, there are RCs from other
vendors that include more than one Root Port, and I'd like all the DTs
and drivers to have similar structure.

Bjorn

