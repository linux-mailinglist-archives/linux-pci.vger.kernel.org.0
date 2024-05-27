Return-Path: <linux-pci+bounces-7847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A38D002C
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86E51F235DB
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0115DBCA;
	Mon, 27 May 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="SxlGbZ5N"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041838FA6
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813510; cv=none; b=T1huT83DCkj3Bk4pRcDbjx8Pmfa3kZ7WHoCqPDylXHccV8ArmOJ0fAn9wjl6Qe3GoVa/vvmLC7HwOg5P3iPxreEWHglU0w5eob7aMxZUOI7N4kLzNvV4ue7LQJZZxiKGZiJ04H1A9OVhMoIq5tJme1fjJjZ3s878XXA2VQ306Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813510; c=relaxed/simple;
	bh=8ck6E6QJP6R2qOdqM+z6mzcga9oTF90+2wV0vt55Fto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8lsySIzd+PjUU1fAUGq2c3zE+zVf5HB9kn/dvsLruTkzlasoL1Dfb+MmyN/diZ6VmnY8+Uj6K0GHPJifCewwLnuxJuRxS+D/ZSqLdiP3Nh6X77nc7BD4NqKNoho6r4TDwq3Tc3Rc/GrErryekln7UPR82+u7jhA9GwyrV4RY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=SxlGbZ5N; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id E18A32873A0; Mon, 27 May 2024 14:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1716813503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfUMb7fd6SNCpSYIvghbKwGqcbg+FX8CiYypi3W4xO8=;
	b=SxlGbZ5Ncv3grBVgkCV2XyvPE2UurwkMWbE91PhjLSR/kVShwwH6bWO8yq3Kc/gv7YPwAM
	Eb+8VHcZtnQABoPLqvBv/IXD1caMNa95s3o2RKCrg35H6AAqnCJA4laiUk0hxEeBQuqJCu
	kVJJNiPLAA42leR1rWmKaAUYmv4iK7g=
Date: Mon, 27 May 2024 14:38:23 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH pciutils 0/6] pcilmr: Improve grading of the margining
 results
Message-ID: <mj+md-20240527.123808.16578.nikam@ucw.cz>
References: <20240522160634.29831-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522160634.29831-1-n.proshkin@yadro.com>

Hi!

> Original version of the pcilmr utility used values from the Table 8-11 of
> the PCIe Base Spec Rev 5.0 to evaluate lanes. But it seems that these
> values relate only to the margining equipment and are not relevant to
> evaluating the quality of connections.
> 
> Patch set improves grading from two sides:
> * The PCIe Base Spec Rev 5.0 sets the minimum values for the eye in the
>   section 8.4.2. Change default grading values in the utility according to
>   this section. Keep in mind that the Spec uses full eye width and height
>   terms and that reference values depend on the current Link speed;
> * Manufacturers can provide criteria for their devices that
>   differ from the standard ones. Usually this information falls under the
>   NDA, so add an option to the utility that will allow the user to set
>   necessary criteria for evaluating the quality of lanes.
> 
> At the same time, fix the known limitations associated with arguments
> parsing.
> 
> With the new changes made, the logic responsible for arguments parsing has
> become too large, so put it in a separate file.

Thanks, applied.

				Martin

