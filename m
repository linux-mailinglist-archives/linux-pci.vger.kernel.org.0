Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFB6A5FC5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 20:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjB1TiB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 14:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjB1TiA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 14:38:00 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EAB7EF8;
        Tue, 28 Feb 2023 11:37:57 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 55E676C1742;
        Tue, 28 Feb 2023 19:27:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6E89F6C17B6;
        Tue, 28 Feb 2023 19:27:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677612460; a=rsa-sha256;
        cv=none;
        b=k6ZTnFNcm+Gw7N+vRgQ8+wMXz+d4eqQDKNk6d1eiKdjnjd2iSsX1TfQ86IQmvGNnZ+72AF
        Ne2vYLd306rtWThY8YbjL3X9eAQmkm+4JyPQGHF8ScjRSAjy5Da05BSjr08IF5yHhPliar
        Bt+j/JOFfBu301E9ufl/bImQfrGThMYeVsZPrAQbO+v+7Radb88LV3chcAn3gmoQh2H3bF
        PIt+8pLlybFK24EenEpOv+NGYYElRja3Vcn6W3FZB1L8IS2PQuID4cPrHnkDnrYwdqgh+4
        BHtRSBsc6Ayrznd7o4Pb504AAvklS4uvvXKueonxK9YZ4Ip1Yg8Jg8MvJ2lSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677612460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dk5WC6pNDNqupdzyp4cDonVGAuDqWa4eWwNCh1lR9Rs=;
        b=PWS5TcsywUxao4hG8pjve4uPTD2TFCSVbs3zYeLGSc9Ycm93pK4CTwUPJUjrMB3abVYeN4
        cevWlf2paYsyXNd1YCPG6czMjevh6f/H3V8RwOIJKAjowH58EDsHc5nyPugMVe5yq2tzSg
        LmJFjUf89ZMwtBFrdPp3JGeQ0RA7QKdyW3xKOv8aTp2amxgyjkC2b0rjso2QplW31CNTtF
        w33BFUEQFAmw1pc7neKSD7GhBE2PnzBAts4fNAr/JXvayl3RhXYjHzFXrz8XzjeIH8JHyF
        4NHUmg8nZrFUnd01S4eGdn/E33VA+vcxhTCCRp3nrc+oqqeMPpOH2e9VZDw93A==
ARC-Authentication-Results: i=1;
        rspamd-fd4f5fb8c-bnhpv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Eyes: 486024d36cc4379b_1677612461130_2814926323
X-MC-Loop-Signature: 1677612461130:2408468017
X-MC-Ingress-Time: 1677612461130
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.14 (trex/6.7.2);
        Tue, 28 Feb 2023 19:27:41 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4PR6p25S1Dz147;
        Tue, 28 Feb 2023 11:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677612459;
        bh=dk5WC6pNDNqupdzyp4cDonVGAuDqWa4eWwNCh1lR9Rs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=akDvE2EPbwvxWk3kS5oecKPwUbj49/mIeAvMQqHhJ04B9ZEmq+UUPxfAn6TsQzRyX
         SYH1tJMh6CUJEPtbkfYK3NBKi/mbXHR6o5+6QyOet+1llw1BJfaVWVPaiVpG7I9v2K
         Xx342NQPBocDPU35Ad081KjshgunI0riwO0QXkQnxAAjS3Nk1uwYxn/GrOVzkkUTH+
         9KaIOC5q5ww/qMWrEMSOJb5LehTOjNc/6WgqFbfvrrYeil3/eHENkPXg8zS/s+hyUO
         3qf3yIDF48ezVl2y6Hm4FPoEvoUED1cBCcaw+FupBuyAco/L7vj+bqoxWYjQrfLKAu
         z0p8tj69Chr/g==
Date:   Tue, 28 Feb 2023 10:58:57 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 07/16] PCI/DOE: Provide synchronous API and use it
 internally
Message-ID: <20230228185857.hvktpiq7nxcx5xch@offworld>
References: <cover.1676043318.git.lukas@wunner.de>
 <5953272685cd245a400e5e0bd964573d9102eeb8.1676043318.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5953272685cd245a400e5e0bd964573d9102eeb8.1676043318.git.lukas@wunner.de>
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

On Fri, 10 Feb 2023, Lukas Wunner wrote:

>The DOE API only allows asynchronous exchanges and forces callers to
>provide a completion callback.  Yet all existing callers only perform
>synchronous exchanges.  Upcoming commits for CMA (Component Measurement
>and Authentication, PCIe r6.0 sec 6.31) likewise require only
>synchronous DOE exchanges.
>
>Provide a synchronous pci_doe() API call which builds on the internal
>asynchronous machinery.
>
>Convert the internal pci_doe_discovery() to the new call.
>
>The new API allows submission of const-declared requests, necessitating
>the addition of a const qualifier in struct pci_doe_task.
>
>Tested-by: Ira Weiny <ira.weiny@intel.com>
>Signed-off-by: Lukas Wunner <lukas@wunner.de>
>Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
