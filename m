Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24E539703
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347282AbiEaTaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiEaTay (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 15:30:54 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B0F4ECC8;
        Tue, 31 May 2022 12:30:52 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6734D222B1;
        Tue, 31 May 2022 19:30:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BADC8219DB;
        Tue, 31 May 2022 19:30:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654025451; a=rsa-sha256;
        cv=none;
        b=GHifxgTwTgrq50J0ahKG4ErpRp9ja56wxBpHwUdWDzKqCh9KCP7/jXATIGbn+xAtSH6yoQ
        KueNIZiFxZGwDuBVi8BPk47sobiLt+za791gGQg2hdS8oHsapyVWT/AILdSYQXtwAkM8An
        qb8SiJ3mHU+SfwvHjQSVxk0n2oDPysdZMmWngFep3j5TorJsnGQwS7tGbibWPneVeBKo1w
        QVRp86H6ip1Jq/bTAD6hPE41tSH0TEm9sv/0+/kCFIggzd1LOC8r+mGhJl0o/67x1DOZrB
        V1+FRjmYR6/UpmHLtAA8ygiFzGFl5TRJQ8ysLniWVlKyQcjx3lQjxL9yYFuA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654025451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=yjn8g0oYlpZ7Ojn4qLOFR1xRrZRUZDYgF0eVYsHCCQ0=;
        b=fujZ9FP8dPSbyO80Yj1rYWggz4veP2J3COoTaixttgqa5PBTUtxG4ou7SuwUXRyjxUKbL8
        o8aHCRfZZw2G+u741S8ncP4YbyZKPY6mNJgTYtzkUwaC9wQhktjlmkLZJLdST/Ygs0YHeJ
        uYmLOFhHijlLU7/ZIpdIDnaBeQPIk2ilm8qNTczEeskebVlckUDudHMdLj3gPOo//yG4u+
        3YsSVpEXaPS0exzbucxPZk38Wb4Jl144bpfF5mMJ7MYYNyMX6QoaegpBEmkh6729y5pYvB
        6Ohiv/xXBFPsBpgp4CJZ+d6DTb8HoOSmqJbK0KL4toe1EvSOCtjQSC8+PYkj8A==
ARC-Authentication-Results: i=1;
        rspamd-77f9f854d9-fnqkg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Bottle: 1914ce2e120b5944_1654025451251_759484802
X-MC-Loop-Signature: 1654025451251:42469579
X-MC-Ingress-Time: 1654025451250
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.15 (trex/6.7.1);
        Tue, 31 May 2022 19:30:51 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LCMnj43XQz3H;
        Tue, 31 May 2022 12:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654025450;
        bh=yjn8g0oYlpZ7Ojn4qLOFR1xRrZRUZDYgF0eVYsHCCQ0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=IgsygmY6NMceIkGxHDSbvprysRtVmtuA8F4dNs5xvCERvgZDGp9kbH/7PuI8hle9s
         1/J6o44NYyTzWk23dnJJCpNsXK/45l8Rv63/I+dgpLeqMnkXK0Tv/3WQtKyXW8+lGW
         sVHgnYhquzcLN/azgnmCjqdynpZRS/B6lXp2cpA/nbxyIglj3f+BsyAJItyUkQT1ie
         Wq5v0y86nWzyWsXQg5JTmfoVn6n/Sd58HvhdHL7skHkxc/rYea2zZ3eJrj8Ei2vgV0
         HVxIzDYJzLFesaPS5yTCY2jazXguwzItuNc9mhvhjByTSHVmHaiiEDabBq4imGqcBu
         qopZmGgQrLHyg==
Date:   Tue, 31 May 2022 12:30:46 -0700
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
Subject: Re: [PATCH v9 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <20220531193046.g34gjadvd4gq4i3p@offworld>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220531152632.1397976-9-ira.weiny@intel.com>
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

On Tue, 31 May 2022, ira.weiny@intel.com wrote:

>From: Ira Weiny <ira.weiny@intel.com>
>
>The CDAT read may fail for a number of reasons but mainly it is possible
>to get different parts of a valid state.  The checksum in the CDAT table
>protects against this.
>
>Now that the cdat data is validated issue a retries if the CDAT read
>fails.  For now 5 retries are implemented.
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>---
>Changes from V8
>	Move code to cxl/core/pci.c
>
>Changes from V6
>	Move to pci.c
>	Fix retries count
>	Change to 5 retries
>
>Changes from V5:
>	New patch -- easy to push off or drop.
>---
> drivers/cxl/core/pci.c | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>index bb370df1cb6c..7f7dac9030a6 100644
>--- a/drivers/cxl/core/pci.c
>+++ b/drivers/cxl/core/pci.c
>@@ -620,20 +620,18 @@ static int cxl_cdat_read_table(struct cxl_port *port,
> 	return rc;
> }
>
>-void read_cdat_data(struct cxl_port *port)
>+static int __read_cdat_data(struct cxl_port *port)
> {
> 	struct device *dev = &port->dev;
> 	size_t cdat_length;
> 	int ret;
>
> 	if (cxl_cdat_get_length(port, &cdat_length))
>-		return;
>+		return 0;
>
> 	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
>-	if (!port->cdat.table) {
>-		ret = -ENOMEM;
>-		goto error;
>-	}
>+	if (!port->cdat.table)
>+		return -ENOMEM;
>
> 	port->cdat.length = cdat_length;
> 	ret = cxl_cdat_read_table(port, &port->cdat);
>@@ -641,12 +639,24 @@ void read_cdat_data(struct cxl_port *port)
> 		devm_kfree(dev, port->cdat.table);
> 		port->cdat.table = NULL;
> 		port->cdat.length = 0;
>-		ret = -EIO;
>-		goto error;
>+		return -EIO;
> 	}
>
>-	return;
>-error:
>-	dev_err(dev, "CDAT data read error (%d)\n", ret);
>+	return 0;
>+}
>+
>+void read_cdat_data(struct cxl_port *port)
>+{
>+	int retries = 5;
>+	int rc;
>+
>+	while (retries--) {
>+		rc = __read_cdat_data(port);
>+		if (!rc)
>+			break;
>+		dev_err(&port->dev,
>+			"CDAT data read error rc=%d (retries %d)\n",
>+			rc, retries);
>+	}
> }
> EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);


Better a single final error message after exhausting all retries
instead of each time.

Thanks,
Davidlohr
