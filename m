Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98F766A14A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjAMR6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 12:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjAMR5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 12:57:54 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21156C049;
        Fri, 13 Jan 2023 09:51:08 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 40A203E0F9B;
        Fri, 13 Jan 2023 17:42:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 99E533E1268;
        Fri, 13 Jan 2023 17:42:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673631758; a=rsa-sha256;
        cv=none;
        b=aB6xa21VDCjs87dpabaUSa9RMma55OpPQaxzs5/hFiR/txUcRRtBhKPJN9Lf8kypZUGZve
        OtaBHAQ7lJb45wZtVNvWkWy0UjltwLbKs+fM7/TV6MTsCzIZxNm7ve3Lm92e+lKQOT9/M3
        x2ntuoAkr7IkXFeUK+r436fblVe20jhUhg1dMbR2zVJo8HVvQBFe6/hsAuoVO845FMrwd1
        DJaHz0q9gaJkEBB0RpQykMWm/kz77h9n/xWvu4t5efnoGvLA0iegQuDA1WLsltdJbLYeK7
        sKD01uBJh7ANtcJ+PB9U17U8AqTBnx3w0q1fSklosI2iA8PnCfO0LWFepTbkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673631758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=twgTTPRo+VXnNzflsrxDFTC/SO/Nbxj3cfBkYLW1hkg=;
        b=33tB9wnNeVgJi+brT3FXVWGpHrSQprQzqzii7hJosZZtJdQCCj6dbkmrDasJE6JtHzd8Xx
        bcKHi5hodfbnA9Bfits86Y1WQqQnCXzjR6WHqbW5OpxWcJOJLsosFJLh2xlbmVK82f445F
        IQpjW7kfl3dqi6M4Fjg4kzYmU1ANGpRLR70vKS5thPIF3+qIM9GWgPX2ZeRcwivWmO4yqm
        YXxfdvpo9ZSBbSgukYfOiAsNC9S1hq/6tRoqKe9VQP7RVNsxnKHKp4lJgvvTClLZrkQLt4
        y8PMnTZQ9fxmBgzyLO08X3+gsnMXnDhLIMQgU1D4vpYJDCkvHL29vssuWL6dSQ==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-pz4jf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Oafish: 11b8c2af1ed5ac8b_1673631759033_935896507
X-MC-Loop-Signature: 1673631759033:1125857754
X-MC-Ingress-Time: 1673631759033
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.85 (trex/6.7.1);
        Fri, 13 Jan 2023 17:42:39 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4Ntpf51GyWzGX;
        Fri, 13 Jan 2023 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1673631758;
        bh=twgTTPRo+VXnNzflsrxDFTC/SO/Nbxj3cfBkYLW1hkg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=pK5KpZ772hyobLbvM90Mxb120RtMGLRQc1NTBkdqzOnDx4KQzICc/QtGrON+qOaR6
         UZaq4nyW/+as5VqCbYpmIdiLzuLlmtJuwtURrOdUunDEOnzlziG6N/1kmiV1al23IR
         SqK1fErGH759hq9eNs0oZb6AfS72PbVIxAT6Kdc60FyaTDIt3mKElSxhdAgMGJadx2
         e7q3CGcKDt2AV6RaOapdZ0DIuCkfRrN23NiCnx67+bLvwVWqwl0M4HL33DuTKtNmrH
         BDg+9bqi9hXA3bvRoHKoXA0ht9/gEKVoWmFNkbweLOG/i13+xd2e7igG1+9Pmkzygi
         ScYv9WSjENQfg==
Date:   Fri, 13 Jan 2023 09:16:33 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 3/8] cxl/mem: Trace General Media Event Record
Message-ID: <20230113171633.2ooichii3jk4exqe@offworld>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
 <20221216-cxl-ev-log-v6-3-346583105b30@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221216-cxl-ev-log-v6-3-346583105b30@intel.com>
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

On Mon, 09 Jan 2023, Ira Weiny wrote:

>CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
>
>Determine if the event read is a general media record and if so trace
>the record as a General Media Event Record.
>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
