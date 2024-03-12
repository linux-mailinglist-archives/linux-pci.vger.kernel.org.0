Return-Path: <linux-pci+bounces-4763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A7879ABB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 18:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F0F1F23E96
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0501386A8;
	Tue, 12 Mar 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVOtYWzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A037C6C4
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265038; cv=none; b=IarJJHH+B2yASQFp95gqtHy3pHfkTA1I0coBhWeM+A6BsPNEAc9tKO02oIssIHeckjWMFPMWGzScP5sYKiKg9WBY4ww56vLaJJGuJDgX4tE+QUCplGWnYDs4fmmD41yGPOY7+s8jbWI9otAnKDi+T+v22AATRVS1txVgfaxrpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265038; c=relaxed/simple;
	bh=FedRMKMSm53NKVDE7Qd8DvpcN4fHaOdReOgZWOZ1iiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bmiEgzb6OOr3Q1X1r6M18IFHhmcwcRPxPaQ8YCpVjf1QWnY5pSTiTo6BhmDUDeYiSevC6DVTW8M9YZxVdLostyO7TZhsYaddATtnKAc+U9s9GYMG+uK46MGAAijtRBazVG/GHJ28xkWq5fXnaQtw3FJ6V1NUq2khFSrsAeas7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVOtYWzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8338C433C7;
	Tue, 12 Mar 2024 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710265037;
	bh=FedRMKMSm53NKVDE7Qd8DvpcN4fHaOdReOgZWOZ1iiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nVOtYWzO3N3XPC2RfKVBalunWoN+JOIP3225ZXjOldUsYlEL6jkm6i8dT7jWCmNgE
	 FoU3jowo3f+1wkcKu4AjVsQ3kJet2bp8m0OlmvjDMjYsj/lme7Kf+S8NZrD9aapfLy
	 6JQsH0Daccc8V69uQ+go/skA1Lv8dQ5no4renmghJq3281UNl1HAqsRTENUOtjJmip
	 KwL4O/UwyiYxDrWtZyMq7B3kbf/4NEydRj8eBSLC70vZPrsaS1c5hQXKNyMM6ifrOU
	 vylG9eiF0tKuJo5NqpaYSECAi50BAHKKUMehVFWV3Lzh+kcbakiwHPRPeQpyZbqDOX
	 ZOVzK2a68LEsA==
Date: Tue, 12 Mar 2024 12:37:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: AER: Corrected error message received from 0000:00:06.0
Message-ID: <20240312173716.GA853913@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2269edc-2928-426e-ae09-d555f239ea79@aixigo.com>

On Tue, Mar 12, 2024 at 08:35:31AM +0100, Harald Dunkel wrote:
> For the records: Booting with pcie_aspm=off seems to help.

Thanks the bug report and the ASPM connection.  We have some important
ASPM fixes queued for v6.9, and it would be interesting to see if they
help here.  The fixes have been in linux-next since about 20240307, so
that's probably the easiest thing to test.

Bjorn

