Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93587191B4
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 06:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFAEVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 00:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFAEVB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 00:21:01 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D2B101;
        Wed, 31 May 2023 21:20:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3F9DD8C2021;
        Thu,  1 Jun 2023 04:20:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id ABB228C1F36;
        Thu,  1 Jun 2023 04:20:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685593258; a=rsa-sha256;
        cv=none;
        b=BdbjzErGq6v80wOWwi2VacehdOLmDDzUef/Ivj90y1yyjYrd2ZqMz/naR1tbBVPjhL3QkZ
        tslE/906L936abXNCYxKzY+t3yTJWA93A9blnMaEQiwABMYds/KdBKArXQ572f31jAGt8t
        mdvRQZU4iWPCgt75ZbWVSKAzNYvucuo/QVdXVcroAdTueGYqUUPieRR955x6Uj9M5pY1dd
        6vG1qhXxFF3ptL2WHpBxgWgWjTimXNMb9QCOZVG4xPqp2ePgHrKm5B3Te2wEWYrqy/fAWX
        2tMzZPfW2so8icdH7sglUlVK4w9EzZCPWIjJ/9vQL1LGehFUVUiI3/0999houA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685593258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=YKUYW9MMboE6NImD3jpIGzcjkz1Sx8imCsGATqbsc7Y=;
        b=gOiZZdwntaUARe4H9qu5yhDmhsrKu+uuIBNYE+XaF/tm1nDvk+AWWzima7ifU3Sjzb1P/W
        nvb65jvCSuNk+7MASqNv5wbwspv680nLJj3lXqUXoBZlW0832udAk+8WmxOpGGkCICTvB8
        JiUoLd7FGHGj+avo8cqv84yz3vK/gQvzpKqR/VrtxMGU1ZhjDPaZBmKdjqXJSNEYBoIaOu
        Ph0SKXELo825iF5kFfgJ56wEQlvkqD0TjFUr43YpC4MTmmwwgxXXdrxKgULMQZ+PhaTemN
        lOOl3puvzH0BOilDptSX9i6aXIpcDj+agTkNn3Dq06cYpV2u05N4+DngEYP0Eg==
ARC-Authentication-Results: i=1;
        rspamd-58dcc7d645-d5k62;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Robust-Lettuce: 7b7b1af03d6a4c90_1685593258927_719203131
X-MC-Loop-Signature: 1685593258927:3178244814
X-MC-Ingress-Time: 1685593258927
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.49.254 (trex/6.8.1);
        Thu, 01 Jun 2023 04:20:58 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4QWtGx3vMXz4s;
        Wed, 31 May 2023 21:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685593258;
        bh=YKUYW9MMboE6NImD3jpIGzcjkz1Sx8imCsGATqbsc7Y=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hSWzwmIcIT3s7IuMFb7M0yAeXQqg6bho4aiaJkQTU1ZoMAf/ic0wcC9gc86DqxKy8
         6WYDS6iUto6DRlvtPknE5HKtxbOTybIoxCihgDsVqYUeRkU71D50Qr8xRqDz+Mkbee
         jCqBFYn4qM2fHJiHCTtD2bzd0NNMkKVOYiBWAwMe7x0cKJTgGd6ypUSQtftjelWv3H
         tYERHh4Tq5BF436SMXJ+HFyLqkaW/RmUuVOEnzWEd3EJ7soVi7T6czQPbeRmVDGc04
         AXygnPF+uqese3FOL9R40lsTxEC7knICe9ZNlP8vgE93T0Ilr7n+NHAw5ske7L21/R
         bx2sKDr9iqFBg==
Date:   Wed, 31 May 2023 20:46:59 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, LiuLele <liu.lele@qq.com>,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, bhelgaas@google.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com, helgaas@kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, vishal.l.verma@intel.com
Subject: Re: CXL memory device not created correctly
Message-ID: <ns63paacatejvt5udpj7ssnyzp75aphbenw7ac5o2xcjiln6l4@lisofmey2kca>
References: <cec6a8f5-a284-4f46-1ada-4edd625a9a2e@intel.com>
 <tencent_D9D9D358330CA573E23D490C6EE13E0DC105@qq.com>
 <gbsxrcjtnf67jxpqmbn57nqoslpmjtuk2ycatmau3vfsmpvbrd@c2umpofn2hti>
 <646793cc665bf_1231462943c@iweiny-mobl.notmuch>
 <ZHaubgQOFU0+r1MD@bombadil.infradead.org>
 <64780c904d3c_c35b294ce@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <64780c904d3c_c35b294ce@iweiny-mobl.notmuch>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 31 May 2023, Ira Weiny wrote:

>I don't think the kernel should be changed for following the spec.

Agreed. If events are mandatory we just have to bite the bullet.

Thanks,
Davidlohr
