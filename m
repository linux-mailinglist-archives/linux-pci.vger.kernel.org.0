Return-Path: <linux-pci+bounces-13984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67803993E6C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 07:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821DB1C229E8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 05:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5C12C484;
	Tue,  8 Oct 2024 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="q4mPHQyk"
X-Original-To: linux-pci@vger.kernel.org
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8407762D2
	for <linux-pci@vger.kernel.org>; Tue,  8 Oct 2024 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366175; cv=pass; b=JJEQk8YeP6PKQupAkWfN0vIVt5XRMscfZ3N1Rh09qHBUxiDz4q0NCUkUgG4NWIXT1r7ea9xHEpbsexBj+JQojUO9riPgTrua2yZuh3jpqKWJJHNG8HnTXEPlS1uUv3mFJ+vP7FH4Py0cZVtgNuRKOPnrq6EcxbN+7zae6q0qruU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366175; c=relaxed/simple;
	bh=yTz7goaAG5CAqDTe+Hg4xEdnfdba9vprJQklvyelWQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2MoyxVcMYZX12yaX5NOFIFL1uh1+gQnOD05asy284uQCGQy69U588dyUsWVJuaJhb1g0mIf6Hi2mu3699LzHGzISSZzFT7Yrm1Rzf1Tf+RqhQ6SVr33WFozruP9SmwQm4A+33hFR7tFjezGSUNW6O81BR/Amf47TAVYgeS9TTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=q4mPHQyk; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D14801640DC;
	Tue,  8 Oct 2024 02:15:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a271.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.101.175.87])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6AF9B1652AB;
	Tue,  8 Oct 2024 02:15:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1728353705; a=rsa-sha256;
	cv=none;
	b=u+6nv4p6ROVrXADK48jmQGrlI+apIUqwHXVcahwL6ibOKZ6fKE5eIfA678NHki8+5ctHKJ
	LrR+8onEVSdfY9WT/ypU7qi+pOLuvOj4mXWzuIn7C8ZqCTOlwm+PLMeFIB5cLBTmM7Z7aH
	FRcpe6orIT0cpjIiSMJnLwTZTzrPyDQyAhaTca/hoQgHNAE2GT+Ey44hd7FlO87kTEaKYN
	91kDqpIsjZoEb8qMRIDNvcE0JOuzrV0rXFR49ymZRcEJfkWIKBxD+S1vxbnzAidzvfb6RX
	qghEzXMBBK7yibd4aFCPDceWko01uJRfrPKNqUPuylDw0yhaKwhX7nb4lUb71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1728353705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0EoJ2JHR5XoPAMxMhJaPDfC6XqGzlNmikS0NuOW7T00=;
	b=q4lZKnJfnMWUaq2zG2J5uSZm+ejQsG0WryY8A5kQkQ3dr2OOhX2+R4fig1OChB+Sew8SNy
	YnrQppUBCEaYlcpgJew7yg/5OvXo5xCJ6Bi6vXHBB/g+Cx/f/QRp4C2AQ9Q6H9G+v5Dx4E
	p8k1Y83q13QBG49Un1wRbHtz4LASo52d286RpsqlN5q/J5tWMqEN76JN3Tu0ULbdyvtUo8
	7Yz9CWUyZGDaqMOcztpxXY7aP9YNhROcriuT5OxW8i9y3BB/AJDUq+dTUQ1JKzaD9Ck7d4
	F9RN3q++IubcdXnSELOrthfVQ3OKMMzxoDpH+WtBfJAn6Si1hjjUaaOjJHjoww==
ARC-Authentication-Results: i=1;
	rspamd-54f99b5bc4-kmmxb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Minister-Company: 7269a57403352817_1728353705675_2575222262
X-MC-Loop-Signature: 1728353705675:1295637027
X-MC-Ingress-Time: 1728353705675
Received: from pdx1-sub0-mail-a271.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.175.87 (trex/7.0.2);
	Tue, 08 Oct 2024 02:15:05 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a271.dreamhost.com (Postfix) with ESMTPSA id 4XN03D6wQrzGp;
	Mon,  7 Oct 2024 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1728353705;
	bh=0EoJ2JHR5XoPAMxMhJaPDfC6XqGzlNmikS0NuOW7T00=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=q4mPHQykZNajM3nyvqenF4sdST6U0R/+spW0Pv8LQ2m9P7TOH74kfpxRkHXp7iXsY
	 8Tfr8VW8QNxk8bYXChaonW7rO3fPkhTFQhVoSPslPrXgptNL5y89400SZSWZJIbfcA
	 y9E9HlCbYI4tRV1RA81jdr0qNGYi469DVlscxQ2cOMIRyP8rxM8HHmIEDgx1iJ7IVO
	 ZoMZRpBJN5v++kGMLfjrahZAHLC5pTe8h9QyGUQYYK6YoNrhNVHavutOIgJUUyehOn
	 W7yW2SItI63onkfvr/J50wAcGjYP1hEGDc5/UWVohpgUgx+w6ssdCvt8xB3RMnZ5FK
	 0fiyBkErIdrhA==
Date: Mon, 7 Oct 2024 19:15:01 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 2/5] pci: make pci_destroy_dev concurrent safe
Message-ID: <20241008021501.gyig3gpnqz5zqi5o@offworld>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-3-kbusch@meta.com>
 <20241003023354.txfw7w4ud247h5va@offworld>
 <Zv6wG5qF74J237w2@kbusch-mbp>
 <20241003170416.kfbdpd7xkneh5sgc@offworld>
 <Zv7bifNNSJXXJgAn@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zv7bifNNSJXXJgAn@kbusch-mbp>
User-Agent: NeoMutt/20220429

On Thu, 03 Oct 2024, Keith Busch wrote:

>On Thu, Oct 03, 2024 at 10:04:16AM -0700, Davidlohr Bueso wrote:
>> Well the thing is it is crashing on me, as reported. I was able to reproduce
>> the deadlock with rescan_remove_lock on a switched CXL topology (via sysfs
>> remove/rescan parent/child). This is why I tested your full pci-bus-locking-2024-09-09
>> branch hoping the last patch would fix it, but still cannot confirm because
>> of that nil ptr deref.
>
>You might need something different than anything in that series if you
>are doing concurrent sysfs access during removal. This is what I wrote
>up for that issue:

The crash is *only* happening in your branch. The test runs into a deadlock
on a vanilla kernel.

>
>  https://lore.kernel.org/linux-pci/20240719185513.3376321-1-kbusch@meta.com/T/#u

This does not address either, fyi.

