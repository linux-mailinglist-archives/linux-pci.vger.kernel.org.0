Return-Path: <linux-pci+bounces-48-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B197F327D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E731C2176D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878958104;
	Tue, 21 Nov 2023 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scX+T4AY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABC58103;
	Tue, 21 Nov 2023 15:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D662C433C8;
	Tue, 21 Nov 2023 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700581181;
	bh=w0swN4qP3atepJXOMo4YxoHycOEd59DUpo/tQX9xLX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scX+T4AYN8zUTppLdAsG0fdse7jcHGsPZah7ukehkVcV2DLf68Y2jiwf9UjFLFwiI
	 LfjqbBCMkeYkNJom3G7XZMZQWBky3tLPkt5YpfMVzwTP6RoJa9WV+7OqeG16cBNXrX
	 5O7dM80aKeDs0Ap8+/aEIDJrtxIKXr9q+meS4G7AOAeies+daGjBF+32/cZx/R82oR
	 MLS2Q0oxm0psoZa5W1vNwYsw9/ht7zuyzfDGO9O9xfPFrHhPPLM+wolUAXIOED87t7
	 WHpe4ZHjo+h+Mszkzd+A0GnP6gHJYxFOVBYgKbA++b9+2w8iLw0R3UexfdK/eRvUNK
	 HcfaIGz3fQnMA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1r5Sqv-0000nP-0a;
	Tue, 21 Nov 2023 16:39:53 +0100
Date: Tue, 21 Nov 2023 16:39:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_parass@quicinc.com, quic_schintav@quicinc.com,
	quic_shijjose@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP
 controller as cache coherent
Message-ID: <ZVzPSQeyVytoyuk7@hovoldconsulting.com>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-4-git-send-email-quic_msarkar@quicinc.com>
 <ZVzE0c8UsW4HXV_u@hovoldconsulting.com>
 <f742b95e-dd42-cbd3-61ef-d5255447ea4e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f742b95e-dd42-cbd3-61ef-d5255447ea4e@quicinc.com>

On Tue, Nov 21, 2023 at 09:02:41PM +0530, Mrinmay Sarkar wrote:
> 
> On 11/21/2023 8:25 PM, Johan Hovold wrote:
> > On Tue, Nov 21, 2023 at 08:08:13PM +0530, Mrinmay Sarkar wrote:
> >> The PCIe EP controller on SA8775P supports cache coherency, hence add
> >> the "dma-coherent" property to mark it as such.

> > What tree is this against?
> >
> > Both controllers are already marked as dma-coherent in mainline so this
> > patch makes no sense (and the context also looks wrong).

> Yes both the RC controllers are dma-coherent and this change is for
> PCIe EP controller and it is inside pcie0_ep node.
> Actually the pcie0_ep node change is yet to apply on linux next.
> I just made this change on top of that and the same I mentioned in
> cover letter.

Ah, thanks for clarifying, and sorry for the noise.

Johan

