Return-Path: <linux-pci+bounces-1556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6E5820058
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 16:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7647EB214A0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2918125B5;
	Fri, 29 Dec 2023 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erOdehdu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBB125B2;
	Fri, 29 Dec 2023 15:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06971C433C8;
	Fri, 29 Dec 2023 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703864768;
	bh=GFzswrTtEow5boAEVOyK6FNRXbRJ7XgpEJcFGJspQ/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=erOdehdu21lroc5pKFHxsXg/7mtSRLyRwG2E+isLoy6tJNp+W9H/RPQEgEF8rfzjH
	 efkm1eSslpRYDMkuiPdgS9RPF1Lmgzmhtq9S9GHc0IH3cPASi8UqutNteUftABPe3q
	 1WhKT+EtB/LuX90AsGBisHmMCYKTrLMQWdXlWs6uvTXuhXMkPLWQfFRttesr3uWaxL
	 IyTRPVaT3z0oZ0S7OndEgiacPGBw0tWFY/ZEVjdx7rMdMWyzTB4syxPTWRRr8XyIh0
	 VL+3UGY31NMb3qQ8lXci2Z5PseObMYBVRNdVyfytvqZrIM2OIhMeCtoTqV3cLRM6mr
	 BGF3VEwO1WtWA==
Date: Fri, 29 Dec 2023 09:46:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: qcom: Reshuffle reset logic in 2_7_0 .init
Message-ID: <20231229154604.GA1577854@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY7R581pgn3uO6kk@hovoldconsulting.com>

On Fri, Dec 29, 2023 at 03:04:23PM +0100, Johan Hovold wrote:
> On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
> ...

> This is arguably a separate change, and not necessarily one that is
> correct either, so should at least go in a separate patch if it should
> be done at all.

A nice side effect of splitting might be that it would be a chance to
put a little more specific information in the subject lines.
"Reshuffle reset logic" by itself doesn't connect it to a specific
issue or reason for the change.

Bjorn

