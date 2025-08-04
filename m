Return-Path: <linux-pci+bounces-33406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5598DB1AAF8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FFB18A34C5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136DC23ABA8;
	Mon,  4 Aug 2025 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAzhOcsD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8252E3700;
	Mon,  4 Aug 2025 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346674; cv=none; b=QyDJO5BYHMO1lcDu+HeatKmd23Tgg/33X5XqOBglxyYZQYaPLKaA+nvxacLhZHiYljgvlOeTS/ufxywHSfMUEcPldBcBw/ia8h1TtSQ80un2cywAmWojmTJfJMImGXmM6XJNejUI5uFCC/jzEIdERISXsHTM6QDrNTvbj9ODA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346674; c=relaxed/simple;
	bh=byLGfkPOeBH7sW/Vb85jpsmMMLb1zFqNvTBK1yT/wpw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sOuzcDKkHuV4sWE9/27X19Aq70yF9A1tp1BOw1teNsoip4hLZeQRUwpwx+7OTuN28ZBYymN5Zts90fx5Kh0XBdXwncNd6UzUp9kmywftPG3pTrliFw29w1Ozml6SAeCRWuetzHZPhqp/cQgPTGE3tx98V4DfLuHSjHg4rOR5cgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAzhOcsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FCDC4CEE7;
	Mon,  4 Aug 2025 22:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346673;
	bh=byLGfkPOeBH7sW/Vb85jpsmMMLb1zFqNvTBK1yT/wpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IAzhOcsDD3u0NqEzw5zHO9KmfAxzO4uoT0RvJ4Fk47jVfFNQUn90/n6LwgXUPnfwF
	 z2drZFqYO/+psH3WSKf9lvvGzCKYDOWkQVtIAAuEzQzTBUxxb5g2uqg9gmOLVApRsz
	 O8ub/fBSTAWYh+33fHmwF7KK18Finacn1FMjqSt1JVc39IDy7TzWzfnVOcVn518wqK
	 Hwh9PQPhm+BWgmshpjFSTAL7ZiEYvzywcllhWO8QFLkvedboE/njdp+fGhxuayFyvh
	 dQox3yB1DTeaviigHiowMCUCFLW2bg9z4YqXFNAf1tch0P6akDMaEVO0CWQEcQCLBe
	 +7cwTLjb2YxRA==
Date: Mon, 4 Aug 2025 17:31:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 36/38] KVM: arm64: CCA: enable DA in realm create
 parameters
Message-ID: <20250804223112.GA3645490@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-37-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:22:13PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Now that we have all the required steps for DA in-place, enable
> DA while creating ralm.

s/ralm/realm/ ?

