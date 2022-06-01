Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A525E53A915
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355475AbiFAOX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355312AbiFAOXJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 10:23:09 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7273F506E;
        Wed,  1 Jun 2022 07:12:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 43A4B6A259B;
        Wed,  1 Jun 2022 14:12:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B903E6A28B2;
        Wed,  1 Jun 2022 14:12:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654092754; a=rsa-sha256;
        cv=none;
        b=zvgdgSUGTwWUAEBXEtSBvYNZ7TtJIAtaRp5H6GYMGomhImSYKfinkKKKe3eVmEP+fSQ8qr
        F71raoKMNSHN8E3mHNh03tU0eiCrxXrVuueBxIEB8A5/9fo5pZt/CRpAYBEOj8Kemh28ob
        xV0R889ak7SZs2p8cIsOtRwd70Z4qi99RfbFNxuHnC3ed+luOS+m9BsOu9SmRR5PXMZBfV
        3mEgESG4GeD40nSA1OaS0SgKLStjCtm27siCV0/nY4DVjJp/SkKFbyfSU5ZIIYYzcGkvAY
        82cHXR9VgaurNVwLs6ue9TbI9dS2iy6qMbUNizTzZyO48zGkauzHWUk9GyMZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654092754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=yLYJaL9ORR9PYZ13P2JQqpUzPce3UQH19Ih6BN8oryg=;
        b=0909y5q2CRn5v5TR0y7rq6Jj2CwZJREDe79Es0ZI3qiWyB0Iqv3pTVQ9O7C3bDPzHwnAQh
        Rv0V9ZVp6ymkChqy0LbzO7tGUIR4mDHV/HIevg16cPMZet1m/V75K6kVxUewxjkQAdVtUH
        kccRSrBfr5Fkd+yGGph1w8l6CBJlkijkBvZRIczRXrE9i3imEXx0UBXWT9VRw2cKZroKje
        vxaDPg90vy+u71LylIw0gQXgGNFOQdWx6PSKg3zjyQtacNAWm/qSkX1xN0e488NNT8XCGc
        6kC5xtjJzS7/FIgj9NPUjG25w76ZJXxUF/KWvNc2tvRPDEUPs0vnS+8tKbLr4Q==
ARC-Authentication-Results: i=1;
        rspamd-54ff499d4f-g4gpm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Celery-Illegal: 52844d101a27ad83_1654092754999_416677461
X-MC-Loop-Signature: 1654092754999:3585670684
X-MC-Ingress-Time: 1654092754999
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.119 (trex/6.7.1);
        Wed, 01 Jun 2022 14:12:34 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LCrh11Kq1z2q;
        Wed,  1 Jun 2022 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654092754;
        bh=uKVBDmeDT/2dQS6ktQaex3oOWU37YZa72inB1fxgwGI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jDlowyjFNsH2P2j4LwIiL0zuUbCC4TalwZm5TssLk3ms94qNuNDXlfZpJqx0Z0v3p
         9V+p/9Ql3HLPxI98jmT3nzYESO4fE7LlIvgfVLQqeBfGq82y5otUfxSn3QJYyqrIn+
         Yjna+xqGq/z+y5N34yK3eXMKIC5pVcM6owL9zWmVB0JRVZ9Ogu7WSV4BurE2JM8Xin
         1tmSG+b0HChMdOALdXKlFMr2i6ZRQ0CVzdPVcHt/Ab2waTogOMQQje35x3T45F9FnP
         LOsJqJqM4L/zZJx5t04n/DZupj6uX/TRDdG1FaC36ux+dge50eUZkJDd65eZCbg0MK
         aotmCpXdBg5tw==
Date:   Wed, 1 Jun 2022 06:59:09 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <20220601135909.mvnam4vvfmofpsdb@offworld>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-4-ira.weiny@intel.com>
 <20220531172507.5ert5tgwellpe7fx@offworld>
 <20220531175652.qog7xaqmypy36whu@offworld>
 <Ypbw3d/vUyMHGcBW@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Ypbw3d/vUyMHGcBW@iweiny-desk3>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 31 May 2022, Ira Weiny wrote:
>Thinking about it I don't see a benefit to a rwlock.  We don't have multiple
>readers.

... but you have concurrent workqueues reading the value of cur_task.

Thanks,
Davidlohr
