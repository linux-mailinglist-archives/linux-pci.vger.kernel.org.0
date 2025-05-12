Return-Path: <linux-pci+bounces-27585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4083AB39EC
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 16:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593D27A18AE
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F71DF757;
	Mon, 12 May 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QvDgyhgf"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84711ACEDD
	for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058453; cv=none; b=JJusBpP6oYh/UcfbCVZe1tIbrudaSXwLVd2aqe4brWzCV/ze5+knLV96ccMwqVSrZ33GSRfiy1cYia5PTp5uEeicdjUEjiDyAFxIDa4k1ds9xyZYWAX8KHOciKdHyhIRcgrPLaKobGKoScvLs1JmVDzFKVyriTq7mA+60vUIV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058453; c=relaxed/simple;
	bh=JkdKaL2iFKo4vgbPLrWo2J9XuIX7Fdk8UQcBDH+Xj70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipYUTFWwf5u5C7mkj9xK3dFNoFYEZaxff3iZ4S915CzrA41vDUqYWOfU0GljmGmCLQFQUkCohpCo1U/a4Y6OMZ6bmtLDR5InjiR7H/PkHAHn+0uiFNRQhwMgLCfr4ofrIYk7F3m35uTvlW6qinMFRLN0lvirK+OfExWox3yV0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QvDgyhgf; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b01a3ae-4766-490e-939d-1d16c2748644@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747058448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJt0rAK9N64ywS+8cjcx1q6dtT4JHAquqNHQUOsx420=;
	b=QvDgyhgfH+F49xOXo1L5Ci9KfvFz/EESz1u68D9NsGzDoho3327H878UxaSIIGCBihxQ6g
	46TLkmYAR9NzF9k9nift8belENT7cwvAi8SMeuU/3tpk2O4MHZimao8Mbwo1CYJSNRXfVT
	uGbgL7dRayK2pZX5eFjvzE3frNNkdfw=
Date: Mon, 12 May 2025 14:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] ASoC/SOF/PCI/Intel: add Wildcat Lake support
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, lgirdwood@gmail.com,
 broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 guennadi.liakhovetski@linux.intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


> The audio IP in Wildcat Lake (WCL) is largely identical to the one in
> Panther Lake, the main difference is the number of DSP cores, memory
> and clocking.
> It is based on the same ACE3 architecture.
> 
> In SOF the PTL topologies can be re-used for WCL to reduce duplication
> of code and topology files. 

Is this really true? I thought topology files are precisely the place where a specific pipeline is assigned to a specific core. If the number of cores is lower, then a PTL topology could fail when used on a WCL DSP, no?

