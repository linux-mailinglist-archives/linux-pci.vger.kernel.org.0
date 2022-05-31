Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409D7539606
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344730AbiEaSPn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 14:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbiEaSPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 14:15:42 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4E8D686;
        Tue, 31 May 2022 11:15:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 33A7AC0AB6;
        Tue, 31 May 2022 17:56:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2E3F2C0F2B;
        Tue, 31 May 2022 17:56:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654019817; a=rsa-sha256;
        cv=none;
        b=xrug5q8YuK93Ismc0mlBgaRdWubuWlBgnf3nSCCY57B/LzwTv4ylZWMnF84RRVdnOZtOGe
        mahgVC4I0Cfvf9Ix1Zgpqijwjp0jjOPOLqcldrjLHL7KOuhNuL5e0Mr474v8IyYEeSmJeK
        7noBWvx+pg9iEgNTQFzncZ7YbSEu/QkD3LKDYlO6UFH3Bn5mijRGUZFFNfbszNKzWIzIx4
        6SsAZ6S/MnouHBtdl5kmH4tgdvOempiiLSXQwEL7fjulye0Y8ds7i852uYcVOSylDfKmd/
        tm66Gl2AcJiE+eum3zXIXC0xpWrsCAtRlwQaBuaSL7ARML5cvlOAwsq3N6DwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654019817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Jqs4c0ygSjRf8XGruXmwMoD1JNWdncPA8hS82YZvfAM=;
        b=7buWo4C0ty/+fwZmR/qY3/L4XKHYbtgSWcLM7HO8Cowyaludczemxy4EXfeEt0PEkQNSIG
        hWRF6DHovdZBFATsOUrFhg6W/xsqiuUOze873MYnpKVXFfRZS7I6bzvvfYWaHl21ZTNkdi
        /GHIAF9yanJYZORkOg1zwnfAHNwx9I81r5EuN1p9tkILxWn/mfWWW8f7KBTr0Ik8LXAoAi
        nGMskmX2i8Xo73Xdayiy2DWJVzRGFxc25JRRfmcXL9LgRWZtaY1q/XhJY9MWwznvHKAbZk
        aeQdHmxOh7QzHuWrypRN5VEMLlWN1+tIJdQ/0n8gojorLm/iz5NHit0F15sGCg==
ARC-Authentication-Results: i=1;
        rspamd-54ff499d4f-6jrv7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Occur: 4c0cf91f5e9557b6_1654019817965_4068604815
X-MC-Loop-Signature: 1654019817965:1336790883
X-MC-Ingress-Time: 1654019817965
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.255.183 (trex/6.7.1);
        Tue, 31 May 2022 17:56:57 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LCKjM72PZz2N;
        Tue, 31 May 2022 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654019816;
        bh=Jqs4c0ygSjRf8XGruXmwMoD1JNWdncPA8hS82YZvfAM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=C8XEopb91jmgMK3dvEx6kZSh8A6Y9Lb/yPrE0fpEBhAOkZxepnKFXhpjrw8M5/PxA
         /RMUwgcNlcOwbjHRKTKok2ksH0CiPObbhwqlm8eUv6lo6nQZdThCwpgTJE8643DUkO
         AeZJ2YBBLb06lUPoGHFTIqXmGZduwaoS1xfG8vqSWJmJwnqRazMcrUN/0IePof7NBZ
         WBaC9HqXFYb2u2v0OTV5b9EFhZGBFGzerHGDk+fCvVgQHjCouoB4doi7LX6Ob1hto3
         HDxsPvYzkBBJYtbtoIkhXDiBj6IlG+y8QikvO9StV3EYH+ZyMVBXyuDzvc2wZAf96w
         3X18HZJIsmxXg==
Date:   Tue, 31 May 2022 10:56:52 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        a.manzanares@samsung.com
Subject: Re: [PATCH v9 3/9] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220531175652.qog7xaqmypy36whu@offworld>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-4-ira.weiny@intel.com>
 <20220531172507.5ert5tgwellpe7fx@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220531172507.5ert5tgwellpe7fx@offworld>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 31 May 2022, Davidlohr Bueso wrote:

>On Tue, 31 May 2022, ira.weiny@intel.com wrote:
>
>>+static void doe_statemachine_work(struct work_struct *work)
>>+{
>>+	struct delayed_work *w = to_delayed_work(work);
>>+	struct pci_doe_mb *doe_mb = container_of(w, struct pci_doe_mb,
>>+						 statemachine);
>>+	struct pci_dev *pdev = doe_mb->pdev;
>>+	int offset = doe_mb->cap_offset;
>>+	struct pci_doe_task *task;
>>+	u32 val;
>>+	int rc;
>>+
>>+	mutex_lock(&doe_mb->task_lock);
>>+	task = doe_mb->cur_task;
>>+	mutex_unlock(&doe_mb->task_lock);
>
>Instead of a mutex, would it be better to use a rwsem here to protect
>the state machine and allow for concurrent reads for the work callback?
>It is a general interface and a trivial change, but not sure how much
>performance is cared about.

Actually why is this a sleeping lock at all? Afaict all critical regions
are short and just deal with loads and stores of oe_mb->task_lock (and
pci_doe_submit_task also checks the doe_mb->flags with the lock held).
This could be a spinlock or similarly a rwlock.

Thanks,
Davidlohr
