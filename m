Return-Path: <linux-pci+bounces-5371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3608914FB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F53C1C2312C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288B4120C;
	Fri, 29 Mar 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jf6EHeuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xlPP9nEd"
X-Original-To: linux-pci@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC542079;
	Fri, 29 Mar 2024 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699527; cv=none; b=W1erBZvRh1Dh/AiN4xBb64j/sFjRFdzmFd9bbp/RUWpvPFVLYCsXWTz7IcYSJ7wzOWe4YzdW8AmCa8sc5ePpMYH6JCvCiCDvkxABjn1YhiTg9dW8E8icXSv+LWi1c7kVFyr6S47iTXBz2iXx+Pn2bbkWEMerSVgaSHJq2Kuw6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699527; c=relaxed/simple;
	bh=eYtxuEbsiza1jWjD8sK8LFfazqJBSKLzQPw4+NsDBGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiZMxYvGGxXu3Y8mty2mZyBuuP/L946JsMGb0NaJbgeLMSKXjwk7JIEujL7yQbIVp/wPJcJodj1J4GUMeNrFaKswnXcO6dTpo7gJyZeekqX9JuW9foFZM2sggQsuAKrHQy9DmxWUVv1g/VaBpidbxBJitf2gCfDAt3yhCswkPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jf6EHeuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xlPP9nEd; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 9444932009FD;
	Fri, 29 Mar 2024 04:05:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 29 Mar 2024 04:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711699524; x=
	1711785924; bh=aKqCS9RJnx7MtsbbEZJJesa57vTOLC1+PYxUbAXMVZs=; b=j
	f6EHeuDErAZ4ZHulFf9KjXpvNXD9RjFm+NedskzdHwz3158mqE33iIbo+PRPPGe9
	aon329whOHCFBLOrJyqVTqX4V1JJxPBkHSN+JNwCHRXglCNiS9VucXMugBFz7B4p
	Hnl/mU7gVYQDxhu3b8sbOQoVZBcD5xmDLrKAErogxLzfjoSJPckVozto3EEOQSF6
	Z3rohS4bWwvNt349Emf5rwXX6mTpkSixZL2Ez8KWdzh9uXkWMrJZJgI3HLZn4xkC
	FnwGcoa9/wqjFKkrtBzhluZQFrYUKRkNXnUFxDjATQrF8dm+4vaLbitCNFGJ07nP
	SE0Rm/zYudyjhbXOMItnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711699524; x=1711785924; bh=aKqCS9RJnx7MtsbbEZJJesa57vTO
	LC1+PYxUbAXMVZs=; b=xlPP9nEdFDBrfgDB7WhHaVVzrhuCXHEIqVxzUbRLi/Qe
	MVoSfZRnrNJB6RNqp5Ar5rTq7I2sCc3Jrrt0AartLl1PzP11u8zyj1qnd3eMojCo
	SgBe8adup1TtfvPHK3610g5cobS3Lm2m6wGoW1Q9IKlxtfHHdbBSnFgaQepQDJDP
	dHU8ixw9v9kmBohYug49IvBqMgHam4W3UfJVTsHXWIkvST4UPQytP8eMi/zOBQ6B
	yGJSXdEELD0VT296NOH4s5V41A+x0XijoINEhuGEhd0wtHqhSvwELusbC/jqIKHp
	GJHrOb8LiDwtLyNFprxgFjKBeGBYJispNhOEJAs4+g==
X-ME-Sender: <xms:Q3YGZt-Xa4lBvf7byTuTbQbol8-RRsEy3sR1y3TKdQo3GdYXplzIrA>
    <xme:Q3YGZhsgzNhdtKeeeUtkaqVF_YM4SCnxAXOPQuV28ci8vU73fOk-tRrFpLUAwA2wH
    zZudFDkIzRRcJd2lg4>
X-ME-Received: <xmr:Q3YGZrBFBq6uQv6fY_2B-QjfTVqlJjpqxBCQm_ZhnK7R3VjSRuGvOq-zJSK1c8_6mkiXvcq5MI0y0bZTW9ppD7VGfDz62tZQWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvtddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Q3YGZhc4a94vMZywKJNNvTb9CTzdH6G3zwzIToPc9yPonkKDhKu5aQ>
    <xmx:Q3YGZiNQg-uGqzCDzPVA1uc3XNV5w4vQM8Es6hCPiz_O0wIgkPEWRw>
    <xmx:Q3YGZjktE_yNzVBBOJxTRz1VCwH0X9HED5dHiXF2AlJbcOeoJiDfug>
    <xmx:Q3YGZssI9R-YZ7KFRdnc2rrj6WHqCp5tdtVYaFGfg7iXL19959jnYQ>
    <xmx:RHYGZp3dt_awJ8NVUMWCUZCc4t2IOd0I-eYTNKpBv4S-j4XCgZFS7A>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 04:05:22 -0400 (EDT)
Date: Fri, 29 Mar 2024 17:05:20 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "edmund.raile" <edmund.raile@proton.me>
Cc: helgaas@kernel.org, linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240329080520.GB231329@workstation.local>
Mail-Followup-To: "edmund.raile" <edmund.raile@proton.me>,
	helgaas@kernel.org, linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240325012135.36861-1-o-takashi@sakamocchi.jp>
 <20240325144149.GA1432902@bhelgaas>
 <20240326131858.GA140624@workstation.local>
 <kodgse5nq6gqor6iaf5s4qo2h7mfykbor34ewtkjvcgh4iraq5@7fxn3rdch2sl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kodgse5nq6gqor6iaf5s4qo2h7mfykbor34ewtkjvcgh4iraq5@7fxn3rdch2sl>

Hi,

On Thu, Mar 28, 2024 at 06:35:29PM +0000, edmund.raile wrote:
> So instead I ran this:
> ```
> su -c 'echo 1 > /sys/devices/pci0000\:00/0000\:00\:1c.1/0000\:03\:00.0/reset'
> ```
> Playback stopped immediately and could not be resumed.
> 
> Then I received this trace:
> 
> INFO: task alsa-sink-Firef:4110 blocked for more than 245 seconds.
>       Tainted: G        W  OE      6.6.10-1-MANJARO #1
> task:alsa-sink-Firef state:D stack:0     pid:4110  ppid:2657   flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x3e7/0x1410
>  ? tlb_batch_pages_flush+0x3d/0x70
>  schedule+0x5e/0xd0
>  schedule_timeout+0x151/0x160
>  wait_for_completion+0x8a/0x160
>  fw_run_transaction+0xe5/0x120 [firewire_core d9ff4eaf1ffb23a203d413e851f405323b49fec7]
>  ? __pfx_split_transaction_timeout_callback+0x10/0x10 [firewire_core d9ff4eaf1ffb23a203d413e851f405323b49fec7]
>  ? __pfx_transmit_complete_callback+0x10/0x10 [firewire_core d9ff4eaf1ffb23a203d413e851f405323b49fec7]
>  ? __pfx_transaction_callback+0x10/0x10 [firewire_core d9ff4eaf1ffb23a203d413e851f405323b49fec7]
>  snd_fw_transaction+0x70/0x110 [snd_firewire_lib 30b43a591db389bbc6be51459cb243ba1fe1e662]
>  ff800_finish_session+0x43/0x70 [snd_fireface 5f7f3f556960f4838886792be8e9c18aa5089b0a]
>  snd_ff_stream_stop_duplex+0x39/0x70 [snd_fireface 5f7f3f556960f4838886792be8e9c18aa5089b0a]
>  pcm_hw_free+0x3c/0x50 [snd_fireface 5f7f3f556960f4838886792be8e9c18aa5089b0a]
>  snd_pcm_common_ioctl+0xe28/0x12b0 [snd_pcm 24933227879438b755ef98bc4844113025f38cdf]
>  ? __seccomp_filter+0x32c/0x510
>  ? __vm_munmap+0xbb/0x150
>  snd_pcm_ioctl+0x2e/0x50 [snd_pcm 24933227879438b755ef98bc4844113025f38cdf]
>  __x64_sys_ioctl+0x94/0xd0
>  do_syscall_64+0x5d/0x90
>  ? syscall_exit_to_user_mode+0x2b/0x40
>  ? do_syscall_64+0x6c/0x90
>  ? do_syscall_64+0x6c/0x90
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Please mind that current software stack to operate your device does not
support this kind of operation, as I've already sent to you several times.
Users should cancel any type of communication on IEEE 1394 bus, then
unplug devices from the bus (or power them off), finally operate
suspending.

By the way, it is apart from PCI subsystem. Your change is now going to
be reverted for v6.9.


Regards

Takashi Sakamoto

