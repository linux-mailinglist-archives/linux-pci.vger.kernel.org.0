Return-Path: <linux-pci+bounces-35883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FD1B52BA9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 10:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52387BAE13
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D672E06C9;
	Thu, 11 Sep 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbWunSz3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0E2D0610;
	Thu, 11 Sep 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579497; cv=none; b=TtsAi3x38q/RlshFKb5nN5W4errvfYkLkK2sSXZpRMpPz/EDM9E6SBD/yG0CG00pY6kkUFvRoJpp52Lzd51utom0epJTHaR4O1NHPQ8zPJcvUq9MVe1V4e8PKeujdU6teOJFZ6G5ao9Gbw3a+dosNWkX04PBRl7s2ghpoLDUjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579497; c=relaxed/simple;
	bh=aupKySQo1aR93lo9x+vbWbwtDMsEZqCGa6M/3CmX2Bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q5FS8YVQUougECBKaGInowFuagSIACgmOxkTIgCwlwauluAZSg1D7FkosrCdR28pv0sj08nC/ATgQNj1Lh/QJLyhm9VhNgcr3Apq/KD/LkcWmqtOJcFTN2Buz5qyP8kHVEw3P50GrA/CHQJZe6p/KxzLaLQOPenYQQvUf0T+2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbWunSz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A962C4CEF1;
	Thu, 11 Sep 2025 08:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757579497;
	bh=aupKySQo1aR93lo9x+vbWbwtDMsEZqCGa6M/3CmX2Bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NbWunSz3bcJZxhjNoCNH3UOIzYOLq/U2WsBI+4KFGMvH949/HgwS9Ku5eMqcfhMXm
	 /jUNByRKExmiqIH5TdyIi8DVUcncNys0XKzWHpkMx73ew6TImbZXneeVQ5cnhW5uN0
	 JcoYf/Pt/byGo2SxUCoHpz0tqMnePk4ItKyBtGPk9a6OYNElEqYBA/t7bjuMr7GEyA
	 NuMH+b3aSALns5b4U1DOYDx4U474BgGdaFupjKd4F1M8xqCLwdTS05aPBYzUKBhJRO
	 AQm6YfmVZDCB4zj/0RMZrA0yKz2npZaVTwPNqDKTtwcLPRUUiymghUp4LbddRBoqOu
	 pGeOScVujTglg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: dan.j.williams@intel.com, Dan Williams <dan.j.williams@intel.com>,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com,
	aik@amd.com
Subject: Re: [PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
 support
In-Reply-To: <68c1098fd6d3b_5addd100c9@dwillia2-mobl4.notmuch>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-6-dan.j.williams@intel.com>
 <yq5av7lz1rxv.fsf@kernel.org>
 <68c1098fd6d3b_5addd100c9@dwillia2-mobl4.notmuch>
Date: Thu, 11 Sep 2025 14:01:30 +0530
Message-ID: <yq5av7lp2xwd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<dan.j.williams@intel.com> writes:

> Aneesh Kumar K.V wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>> 
>> 
>> ....
>> 
>> > +
>> > +static int pci_tsm_lock(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
>> > +{
>> > +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
>> > +	struct pci_tsm *tsm;
>> > +	int rc;
>> > +
>> > +	ACQUIRE(device_intr, lock)(&pdev->dev);
>> > +	if ((rc = ACQUIRE_ERR(device_intr, &lock)))
>> > +		return rc;
>> > +
>> > +	if (pdev->dev.driver)
>> > +		return -EBUSY;
>> > +
>> > +	tsm = ops->lock(pdev);
>> > +	if (IS_ERR(tsm))
>> > +		return PTR_ERR(tsm);
>> > +
>> > +	pdev->tsm = tsm;
>> > +	return 0;
>> > +}
>> >
>> 
>> This is slightly different from connect() callback in that we don't have
>> pdev->tsm initialized when calling ->lock() callback. Should we do
>> something like below? (I also included the arch changes to show how
>> destructor is being used.)
>
> Do you need to walk pdev->tsm when you are creating the tsm context?
>
> For example, pass @pdev and the lock context structure to
> rsi_device_lock()?

Sure I can pass struct cca_guest_dsc *dsm as an agrument to
rsi_device_lock().

I was comparing this to connect() callback which when getting called
will already have pdev->tsm set.

static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
{
	int rc;
	struct pci_tsm_pf0 *tsm_pf0;
	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);

.....

	pdev->tsm = pci_tsm;
	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);

...
	rc = ops->connect(pdev);
	if (rc)
		return rc;

	pdev->tsm = no_free_ptr(pci_tsm);

}


-aneesh

