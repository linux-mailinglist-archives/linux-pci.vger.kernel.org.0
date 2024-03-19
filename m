Return-Path: <linux-pci+bounces-4888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D391D87F7A8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 07:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C8E1C21A64
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 06:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A350251;
	Tue, 19 Mar 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dQ/rvfQO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N7DGSS4P"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D74F8BD
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830534; cv=none; b=XHtgAVVfBD11/tNkl7qDDvkeCV2I+D2WP/g/5AhqQ9FmMDpstmJ0YXZ0nRFMCLE3BpgUvz2JMaGtRcaKEByetZSrsMdjSnldJvC3lKt3e9qOA98mFbQaIHkMsA8hC8S1xsXZ1RQeKPnoobC4hjrT+rzouRbHU7Rys5aYd+YcWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830534; c=relaxed/simple;
	bh=9ml3MiAdm4xzNbqrBXZKkmzO1oUN7W5bI1TyjoyErAw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XFxU5PapDNrONt12jT6/Zt5Y0dQKATGHmDVSAASuYrvY96uin4Plb5mxuFr9tllYu8iMn8r6+g3sZMuBCSx+kwTTXI5wN9b9QBc3bR/mv3baizVENr7A89L0KUCTpQvH5+xTQKUocbe63MbyTJNdYLzIbqPtH8inyTzG1rR34gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dQ/rvfQO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N7DGSS4P; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5CDEC13800ED;
	Tue, 19 Mar 2024 02:42:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 19 Mar 2024 02:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710830531; x=1710916931; bh=+HyIP0GVG9
	dJkn/+yJFWmqtIyRiVqzyea0BtGIpXeOg=; b=dQ/rvfQOREIIHfFiBUNRqkr7P0
	bdlMKX3ROkTymNQrgNHAlTPMOHphrXPI3DQMitXcOwOgECwYT2hIX+YbF+yYYS9v
	/BiFe5IZCOEzpPUfWnw92KV/w3z4LNGM58Rcd4w71fTWY1ULkb6W8jSkVw0jH0so
	Tb2wJmXNmFzEMKZ13BCqNTQeJIg7nZ9NgiAie/9/iNHHhbo0a6VLWdMEUJpRedhf
	HncwP2kIfydzWsN+NMUYpvUQboz34qeeOZ7ta++bxJxs+i5V/HzZBEls0D2uoS9t
	sXz2EtfFvl12/Fw3Y2UhbaOlMFTJcxEE0vUyZgi6XdgngZi/xoVSMiiJ5IEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710830531; x=1710916931; bh=+HyIP0GVG9dJkn/+yJFWmqtIyRiV
	qzyea0BtGIpXeOg=; b=N7DGSS4PgnwLmKLlTdm6Xm/SnVPfhf2vBDYhl5AZIepV
	//x2RK+M2pavjDl43yMYQsT4YpxAtflWl2yWhjKV3RMKAzzStDRRsoFcbxEGBstM
	BffT1VJQ+fwbv/omB0jpI+k5KSfQo0mka/awiCABtUu4xpK4zGD+64rMc/LfwvSF
	Im55pQQM+O223zd/JX4/lKyQBaJ9Di7fAppAdvStiFWFcw9uQ+qtATD84S8LyRKm
	FmMKca81L7+CD9Va4m60iOnJVKNKH+uWLsovfultN23MrdHemdIIZKndQ3q077/e
	RKO0bU82DIIZGBvYhaReOoc98vxWsb4YYubAaX3UTg==
X-ME-Sender: <xms:wzP5ZTyxKS1YWTekchiai43xbphwobjM1ulTOiywbgHOPzSs-5u1Hg>
    <xme:wzP5ZbR6QmMFAA-_fqrMpf37Q431r8H_kMYEiDJZCxhmzS1ZAgAToTRHakFdfW-aJ
    fINd-XLJBG7VIyh7iU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeekgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:wzP5ZdVO3CoVKtH0m0hcaYgrOuvF0yHuROKFx-qTzIvlk4TDXrQzig>
    <xmx:wzP5Zdha4NUNYZNw7r2TX3_hKutznq8BVqIxqiLShaQ47_fhVxlyjw>
    <xmx:wzP5ZVCCiO3ygXLhxD7NU6_gAZU0YLU-Uw-THiHc28qTVcMMe9rC_A>
    <xmx:wzP5ZWL42cpFr_2FYbwzN7gClPGhvutcxqR29jGLzI7uwWLOX5qo7w>
    <xmx:wzP5ZfAZ0MR0ZpieyW9Ch086XxxtS9z1OUs29ZM9EMaxYi4KNhpnYQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1832FB6008D; Tue, 19 Mar 2024 02:42:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6fe19bfe-f064-434a-99c1-d90094b0610a@app.fastmail.com>
In-Reply-To: <20240319043100.GB52500@thinkpad>
References: <20240318193019.123795-1-cassel@kernel.org>
 <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>
 <20240319043100.GB52500@thinkpad>
Date: Tue, 19 Mar 2024 07:41:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Cc: "Niklas Cassel" <cassel@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR
 tests
Content-Type: text/plain

On Tue, Mar 19, 2024, at 05:31, Manivannan Sadhasivam wrote:
> On Mon, Mar 18, 2024 at 09:02:21PM +0100, Arnd Bergmann wrote:
>> On Mon, Mar 18, 2024, at 20:30, Niklas Cassel wrote:
>> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> > index 705029ad8eb5..cb6c9ccf3a5f 100644
>> > --- a/drivers/misc/pci_endpoint_test.c
>> > +++ b/drivers/misc/pci_endpoint_test.c
>> > @@ -272,31 +272,59 @@ static const u32 bar_test_pattern[] = {
>> >  	0xA5A5A5A5,
>> >  };
>> > 
>> > +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>> > +					enum pci_barno barno, int offset,
>> > +					void *write_buf, void *read_buf,
>> > +					int size)
>> > +{
>> > +	memset(write_buf, bar_test_pattern[barno], size);
>> > +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
>> > +
>> > +	/* Make sure that reads are performed after writes. */
>> > +	mb();
>> > +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
>> 
>> Did you see actual bugs without the barrier? On normal PCI
>> semantics, a read will always force a write to be flushed first.
>> 
>
> Even for non-PCI cases, read/writes to the same region are not reordered, right?

Correct. The only thing that is special about PCI here is
that writes are explicitly allowed to get posted in the
first place, on other buses the memcpy_toio() by itself
might already require non-posted behavior.

      Arnd

