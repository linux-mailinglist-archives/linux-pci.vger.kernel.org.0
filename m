Return-Path: <linux-pci+bounces-7419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FF88C40C3
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF422827E2
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4FA3F;
	Mon, 13 May 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="AHt/4Zna"
X-Original-To: linux-pci@vger.kernel.org
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D21E497;
	Mon, 13 May 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603480; cv=pass; b=ujA9HaFdMSbRHdXUkJApOLhoHMe8Ww0ofL/n+mdNYDoN/qiTFcnu0YirvIq58o+8+zw/ASTjyjBFVUw1citZpBj19ijXDeseskqr+m8wramv3fjJR64pkphvWCBxL5JbdQtyc9A39sOyNZdiVq2hB5Eaq/aZ5zsZv91EVX6Zc/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603480; c=relaxed/simple;
	bh=hPrvqtfG//FeeDbkZ0/tb/c0P/VIar6iLAYnHjbCqfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzB0O+wH4Ybui5gpLWZvHRwSQDzg1hvxngkW7PGPvPLISRLXC5pIzeKILkqBEimevpjPIoYN2yLcHDtoIPO5zMUNkoov3vAx2meu+azC2sIFwv6OvQ36GpY+sO0RkdY5rb4f154faT+R4+vVw6tMaILe3thFFyG60VMP2T+3lIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=AHt/4Zna; arc=pass smtp.client-ip=23.83.223.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B6780C1C20;
	Mon, 13 May 2024 12:12:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a303.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 22750C225D;
	Mon, 13 May 2024 12:12:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1715602361; a=rsa-sha256;
	cv=none;
	b=uG4m60IAFYkzszeN7XrVm616O2s5Bfujwy8MKg/eo3DZX+KylcN6NL3+WTmBKnMqP/6PJN
	q4V/1V8h6kjBiOjmSVNSDUuzAdWF+Vr1nF05JdBiKyOzCFadQJ3hCwyTgTy2niqsWUM0tE
	zUbuJpjNvy8z3TGPPoVAOz2d+Wjr8p7GokL5vV6ug4FMHaBKNUki5i6P0PnTVjkpQFmRPG
	zDlCkwyOBK+mtZCd54qRe68Jj3VS+t/72HvkXICmO8BIdQX5aw33WRNjglUlbSnG9eOEU7
	dWPsmrgoIRVut4bvU3LhYBnBAtTTIUIW2eatQkG/UIdUfHnEGiQTY3IFDAizVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1715602361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hPrvqtfG//FeeDbkZ0/tb/c0P/VIar6iLAYnHjbCqfE=;
	b=dHdK6w+/o0kZBTbhlReoQXeGi7/2IwMc00zlXJnFGICKIw+Ut6qTSkvTGopALiO+lrDA5y
	qibp7asKkw21muUZmGiJBRCR5rD3Qh6scDQWd7CUw9WWspiQyypTLBkETDPGlkpudSn0XD
	dDQZ95DkAzhJVAtm3a19sUBvGpUqWM2sWEp8sZxQ0S80UZyLmJBwuZivDbuZU4vWe5t/3T
	gqAzJVbSvEWN5gvhYxm5Kk7EehL47qjPCiRVlEefar2OvVk4aFZeNZt9YJIGLSq8L1yZDG
	o8JKMjcslwFShvkZQqIxuv1IEiQIXOjGywYWCmL5auUll01XfrD08mTMwNZQPQ==
ARC-Authentication-Results: i=1;
	rspamd-68bbddc7f5-x4p8m;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Juvenile: 564fbc2d6be8202b_1715602361585_4025653130
X-MC-Loop-Signature: 1715602361584:4090389077
X-MC-Ingress-Time: 1715602361584
Received: from pdx1-sub0-mail-a303.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.166.135 (trex/6.9.2);
	Mon, 13 May 2024 12:12:41 +0000
Received: from offworld (unknown [50.204.89.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a303.dreamhost.com (Postfix) with ESMTPSA id 4VdJK402Gpz74;
	Mon, 13 May 2024 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1715602360;
	bh=hPrvqtfG//FeeDbkZ0/tb/c0P/VIar6iLAYnHjbCqfE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=AHt/4ZnaNi+WTA23CkjqYfuawpFYMc+PCxMjpXG3avu51BMow4pHg4OGjBJ2QLFlU
	 DD+U/7Krbp02H6Mt7VhkKhdqb20pKVpwLH1ScXfqD3D4CEHqehCQmzDiNAZT7y4ph+
	 w4XSoj1kpeXWR8bWYl0PnTdkBipPtUFktOBslu21UkFA4ZY6HpNs03viMYFVnKX1DC
	 vS36pn+ki0TtaW3sPr/82M4Ji5OPG/gOpA5SRJaYiTVn8gqZXXh79KFEO5ZuiHI+Lf
	 mBbBsejjQiXQvb70BE92K/08/RSguvcGLXbAAPPa2qoIBoyfp+Am/zX+VtmzY2TZMV
	 bhVIudXxF/WgA==
Date: Mon, 13 May 2024 05:12:27 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Michal Hocko <mhocko@suse.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, 
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>, 
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>, 
	"alison.schofield@intel.com" <alison.schofield@intel.com>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, 
	"gourry.memverge@gmail.com" <gourry.memverge@gmail.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>, 
	"rientjes@google.com" <rientjes@google.com>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, 
	"shradha.t@samsung.com" <shradha.t@samsung.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, 
	Jim Harris <jim.harris@samsung.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Message-ID: <snrgd5o6qe6fdv32hkgrwlkmdlpa5k5naqeishpqlzqr6an5ii@tftzuejc323n>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>, 
	Adam Manzanares <a.manzanares@samsung.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, 
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>, 
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>, 
	"alison.schofield@intel.com" <alison.schofield@intel.com>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, 
	"gourry.memverge@gmail.com" <gourry.memverge@gmail.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>, 
	"rientjes@google.com" <rientjes@google.com>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, 
	"shradha.t@samsung.com" <shradha.t@samsung.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, 
	Jim Harris <jim.harris@samsung.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
 <ZjoVHhiSLm3KRW63@tiehlicka>
 <cd7de8e2-6520-4b06-92be-668aeb96bc40@nmtadam.samsung>
 <ZkC_HnL4lfrNnZkm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZkC_HnL4lfrNnZkm@tiehlicka>
User-Agent: NeoMutt/20240416

On Sun, 12 May 2024, Michal Hocko wrote:

>> +1. I think the performance implications of CXL memory and how it relates
>> to existing memory management code tackling performance differentiated memory
>> would be nice to separate. I think Davidlohr would be a great candidate to
>> lead this discussion.
>
>WDYT Davidlohr?

I think that the relevant performance discussions will happen in the tiering
session from David R.

Thanks,
Davidlohr

