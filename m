Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D316B66A392
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 20:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjAMTn7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 14:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjAMTnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 14:43:37 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35A8B50B;
        Fri, 13 Jan 2023 11:42:51 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 10D61141713;
        Fri, 13 Jan 2023 19:35:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 233AA14116F;
        Fri, 13 Jan 2023 19:35:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673638556; a=rsa-sha256;
        cv=none;
        b=cG+Z2qAz4cvzhunoxANkxGEe2NGjw1Tb1TdfYu2QMjzlyT7iVB62nR8eeN2esf70BavIK7
        naYklHrfGUZOhvh754wUsFVruu6YtoMoUc1Yp01e8Oso5WVh2s37MnQ8SEoxSPwBttS4YB
        nt8rpCY3t3QOtcsPjU1yMyb/14YHz6Xz43HK66ngvjgtigvI419vU7orzk9a/et9LaBebI
        c/nOK5I08t0KC42jqWFuUfYBvKJE7Rk8Yi7NF0prQu1TeEsLbhUeeniFHRyINsPb+aZOlD
        5cgYfEyg9/eIdvGCTAVLz508L/PfgTeSfTpPTHEoNHg8vNVC8u0YSOmZseuGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673638556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4BLKm052qLnpFlYXMLi9U0yMb6GrF0x2PZhYEYe6tjs=;
        b=SFsUmo4XcY0lL/gkoncDmDebZPTyS8N5n3LcP2g6aYoCX6VG20vOfk35q8vISx7EYk+5lR
        EwHJryKFEeh6dvSOX/FlUC4GNH0/i3F4GEOby3/+n5sRpqlPVYEIGT7464xSUOdCzqaZSp
        /hJex31XDhUG5rKggAyiFsLScbzc8JgPQDj/oF3Uobxn35FxiCahyTygXAV5Buf5/2I9w3
        xWAZO1+tJYpUvM44u+Ja7Qca0DnStlieUwj6OgoQ41rDIOto4YTvVCAz6k9T7iyrBzHgfk
        Er+xVvOjTnUm39D3s9Slcby3/ne1nWe+533FS2GVup18HnEwuiq93QL1DJfH0w==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-95cc5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Tasty: 1331cd9b1eee83f2_1673638556780_816576564
X-MC-Loop-Signature: 1673638556780:4214692273
X-MC-Ingress-Time: 1673638556780
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.75 (trex/6.7.1);
        Fri, 13 Jan 2023 19:35:56 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4Nts8p3FR4z3g;
        Fri, 13 Jan 2023 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1673638555;
        bh=4BLKm052qLnpFlYXMLi9U0yMb6GrF0x2PZhYEYe6tjs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ei7fzggKdsKBEfNTyASrwafKvnYprM7I18ZA+QVy1OkOR3FQv0Xl8bmPZxwsFQTNX
         uV0BiixDIiwfGh8v3NtVtfZMhsR+wwA4FSYmdQjesHtOhiSMbW0ejInTVbNrENgKka
         3KOiNFMzZLhaYEtPI/mJh62uof8KTGm62ZiKa2XY9b4LLbWlWKQrGAZ/r3rBa4BTTl
         zzWnl4cr2F5a0D7P1QqAKs2ENLzz140giLXCFmzk5KyoayLDntVoqy6FGNfNmB3Bc/
         3jHJglrAfmB6KvJrwaynZlwkSiIdJfUFALFLJfiu3GHmET9/UoZyjmgOqUxfNjOTdl
         Rj+7PgX4zzfTA==
Date:   Fri, 13 Jan 2023 11:09:50 -0800
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
Subject: Re: [PATCH v6 4/8] cxl/mem: Trace DRAM Event Record
Message-ID: <20230113190950.okeaanjymyhy4ec4@offworld>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
 <20221216-cxl-ev-log-v6-4-346583105b30@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221216-cxl-ev-log-v6-4-346583105b30@intel.com>
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

>CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
>
>Determine if the event read is a DRAM event record and if so trace the
>record.
>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
