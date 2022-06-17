Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9454FEF1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 23:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243982AbiFQUwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 16:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiFQUwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 16:52:08 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B85DD11;
        Fri, 17 Jun 2022 13:52:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 567006C19F8;
        Fri, 17 Jun 2022 20:52:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DDA396C0F04;
        Fri, 17 Jun 2022 20:51:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655499120; a=rsa-sha256;
        cv=none;
        b=kpZKv1CSK0g3cc9uwoWs9OMRgo6+6ZF4ikFqw70H6a6y2BKcbeI7JLbzDuTFIA9otHLe7a
        3vkM899LhUVnIj5auR3lvKixkZrSykMJ99ND+hOSatXI/1ikOWAJ/Tsu/eB95l/XajYEuU
        BCQbyZQ+IPpLOJqYXaacrax/KNIHPEKezdD7hTFAuJC7DJ6ZDWXugD7va/2RKpremRU64/
        6rXUimk9cmOBhkQ8jLbbR9ssCOFRX1m6SvBOQ1BrxPR3QcGqW9HyuYG4JXulf7gC7X6+a2
        eTnlZgBFn8YPL7BK5J5pIvH+3CGhtdMWSKali8TWRquXtiqCCaqlnfb7nCac+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655499120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=H33TwgwIplad2YK1FMTzaxvDoDxT65RNtg46unDmCoU=;
        b=h5v9TlVvfZv5jvbJKsyiJ+IDtnhOZ6IeqyWxyyI6K/Zp9NDL2RbB+H5KqjKXH1r6wUaBRO
        ygx0GDqbhH6nRJWghHHyelazOsWa2QnR9cQBXrp9om1D1HFd+5o0I08QSi6sQ+kpMeGAmb
        YeCCvj1vHOahEDadZubIq7x4dok9cq8uEa4vciX8XA/p0RHm9Wa9+5jXfXPj1LWysn2Ij8
        Q9YUf52QeZj7wAJP6OXTefqfknhkiYtAYU52kt9xYSGkAUvTDOpTbwSYnZZ7iKjAOBneTH
        ZDycoRmlY0idAVEQY6ZeY2Da2aNvT9KHDvp8jhWtxl4jEXzwWOdOwP2MRp9twg==
ARC-Authentication-Results: i=1;
        rspamd-848669fb87-9pggl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Lettuce: 6c19f45016bec545_1655499121003_3845772308
X-MC-Loop-Signature: 1655499121003:2385804167
X-MC-Ingress-Time: 1655499121002
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.1 (trex/6.7.1);
        Fri, 17 Jun 2022 20:52:01 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPrnV0x49z23;
        Fri, 17 Jun 2022 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655499118;
        bh=H33TwgwIplad2YK1FMTzaxvDoDxT65RNtg46unDmCoU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=eFxiupgOiGPatoBnkBlPLD64Fvs+BXBg4mID0ESTwDLcX30idMDhkg9NKA1tkThJ9
         uAUIqPsqcv0DNzfHfSDPMer0UOUhogA524LTICEEyAmnfH0r5hY8lXr04Kmn07haY0
         U7SUJMke0GcNUT45qPMpuUoP91uNVKA8MSztEBiJm+oN9qHnVNmLe06ETQZFITGX43
         BIQ3gGde2+iTnMvYBDIEmhdK3ZblNQPPBzE3uAIlONREUO/Nf7mODb/ta38sfjDw79
         bGt8G0Vs8fWtTBq4Ub9eNBd0ynkjXlk5rTH4i9dKhZw/ZpZ341BW1xac6o89UgTVTJ
         aNcPMdZPq7Bfg==
Date:   Fri, 17 Jun 2022 13:51:55 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, a.manzanares@samsung.com
Subject: Re: [PATCH v11 4/8] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220617205155.yk6qt3qcc3mpipek@offworld>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-5-ira.weiny@intel.com>
 <20220617204046.qdkza6iemkfv2aze@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220617204046.qdkza6iemkfv2aze@offworld>
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

On Fri, 17 Jun 2022, Davidlohr Bueso wrote:

>@@ -457,6 +451,10 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>	u16 off = 0;
>	int num_mbs = 0;
>	int rc;
>+	bool doe_use_irq = false;
>+
>+	if (cxl_alloc_irq_vectors(cxlds))

if (!cxl_alloc_irq_vectors()), that is.

>+		doe_use_irq = true;
