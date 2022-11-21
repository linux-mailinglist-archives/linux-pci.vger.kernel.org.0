Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E2632AD4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiKURVF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiKURUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:20:49 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA9EB480B;
        Mon, 21 Nov 2022 09:19:56 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 67BA7541E1A;
        Mon, 21 Nov 2022 17:19:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C7B53541138;
        Mon, 21 Nov 2022 17:19:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669051194; a=rsa-sha256;
        cv=none;
        b=1AQgRxRqrHMuD0B9PjQcp/G5WDfEAC0ppoFPuf/DyH1UOqKDsl7P5pSEgYR9w8rk3q9QEG
        hQ4oVmm0JtKMetw6ekMM/v+iJfoqepBr9N/pPOzqsbI0vHeXUPnP+hBlxG5CgKfNxAhbFK
        8wyzR7bz73XM3LfUq++k3sc9DB3nShRcW3DEtnIwpKpqPUCPUJeamI7Fs8yjtxDLRQ3mxy
        +esoMPLUvXme6xtlB1dvS6YvwOVl3jHP+152rIjIAe/k/Fe0oWmVqa0iNBqwriu18571vy
        eg2MA7rQ0tgesD5vYZ28SUOmF3oEOb+RJwtwn+TNhKOekhDOrDCLxNxhplPVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669051194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Awet1cfVouXE2vI0H4bD47UQq3RFH+Y6po3HoWdj/t8=;
        b=MqcKepZPDYctXZLrKT6DLXiMloF+PKqltLCLsER//0/GN/M9tlNuI/PbcWIguIGo12alP2
        BqZwKp74SPzhO17iCZn+9+6P+zlgY3/vf3ry57J/MLNLRxpggGrIY1+ZCeHfFYFZCgkDAj
        cOXdM1CZSrAhMuEeLGp9sa7lKqPziNFCeTktselQhZ5WeSH8TbvMlxuDfzcPkJP1jGPDgW
        RRIQel1roSsdfqNWoxJnEN2azJsVJgkcRRfnCI2SXJNg9YmdkGHuhv9lXykesEpQtaDU8a
        6WiXzxX5LnBtmHNLjdu+7Q7z/5lhDO94utZE5z/iyhFypHb5MdLdyOKNvS39dQ==
ARC-Authentication-Results: i=1;
        rspamd-65567d767-pkj8f;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Well-Made: 7e80b4ac2ad21cfe_1669051195168_1626871718
X-MC-Loop-Signature: 1669051195167:1350808727
X-MC-Ingress-Time: 1669051195167
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.15 (trex/6.7.1);
        Mon, 21 Nov 2022 17:19:55 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4NGDfK5T0Jz3V;
        Mon, 21 Nov 2022 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1669051194;
        bh=Awet1cfVouXE2vI0H4bD47UQq3RFH+Y6po3HoWdj/t8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Xbm8KpHKRUK5iPDhpa7uconjLd6+6zTdsWIwGSL/TgjCgZzkF0ZtuBWJ9T0c5LilR
         jDsLA53Ua92fxhGgjzSK6de/w1CR5qhmdWC+a5fpzHHsUcoUonuzWAcDpFM2mJzbD1
         qrmC/VKOFpTeNKNQmEs4ZXlYmgO5rBZbHeLszT5J+fbfENxGkcLJSKWwPKyBYukD7H
         NuF3AOf7tH0/49ohgQbBdViByLACthbZvloqoOvRs5ztFZbDxtFHjdv+du17G2ME1C
         C/HTCn0OQTsmUm+l+3mrRKgePwat0J/PrVDg2Ptn814Y60U3KXlxBDf12vTAD7vqsi
         uuqAPbdz33qhw==
Date:   Mon, 21 Nov 2022 09:19:50 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ira.weiny@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <20221121171950.yflx4nklyqtrhn7s@offworld>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
 <637b98358f7d0_1ee2429488@dwillia2-mobl3.amr.corp.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <637b98358f7d0_1ee2429488@dwillia2-mobl3.amr.corp.intel.com.notmuch>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Nov 2022, Dan Williams wrote:

>The mutex will attempt to maintain fairness in its own waitqueue. If the
>current task in exec_task() sees PCI_DOE_FLAG_CANCEL, it will drop out
>and release the lock and then all waiters can check PCI_DOE_FLAG_CANCEL
>before exec_task().

Yes, and try-locking is hacky by nature. In addition, relying on the mutex
queuing will often be more optimal as it tries to avoid blocking altogether
via mcs (which is also cacheline friendly).

Thanks,
Davidlohr
