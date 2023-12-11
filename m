Return-Path: <linux-pci+bounces-759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86C80DB55
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 21:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9257A2820EA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13715380E;
	Mon, 11 Dec 2023 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaYrkV0B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BEE53808;
	Mon, 11 Dec 2023 20:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BB5C433C8;
	Mon, 11 Dec 2023 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702325586;
	bh=DNj1uX5WZmLEQAxZNomgj9zi2OAe5+dmPakPq58kCUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaYrkV0BT2wFort5fq9lbHfTu0hAVBfT/HbBCXFDjUvEHb4HJLwKcthbHd1RKEO4k
	 ImbJIABUpwPRUKPUn2Cm45jZkw2tw9H8nId02/zNhQ40uWg0oNkCClqVJ2oot1KWPu
	 b3Y4N+zkfIWKiAUJtAVQ1esxAgL8AzMGbkycHvipe5gP2uqoMK9X+kMoROC1hyAY6J
	 4IJfRDKjm8ddQnkkgIkIvCnGgFe3/lizUomUFIl4xLQ1nSDCZ8ULJIi2/pEIycXCRJ
	 mVhoTKNHmcfr3KOCVC5hBbQZysXKUdsQ0rEbCPpj+OVRTLtx2Vs5NqTNZSLouGMQ/X
	 D8FrIhgXp7LcQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rCmf3-0006eS-2D;
	Mon, 11 Dec 2023 21:13:53 +0100
Date: Mon, 11 Dec 2023 21:13:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Message-ID: <ZXdtgdqLWikHR8tp@hovoldconsulting.com>
References: <ZXdIcle5oKJTaQB6@hovoldconsulting.com>
 <20231211181153.GA959586@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211181153.GA959586@bhelgaas>

On Mon, Dec 11, 2023 at 12:11:53PM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 11, 2023 at 06:35:46PM +0100, Johan Hovold wrote:

> > I've noticed that you're pretty keen on amending commit messages.
> > 
> > For this series, for example, I noticed that you added an American comma
> > after "e.g." even though this is not expected in British English that I
> > (try to) use. This risks introducing inconsistencies and frankly I see no
> > reason for this kind of editing. British English is not an error. :)
> > 
> > You also added a plus sign after the stable kernel versions in the
> > comments after the CC-stable tags even though this is not the right
> > notation for this (see the stable kernel rules).
> 
> Fixed, sorry.

Thanks!

Johan

