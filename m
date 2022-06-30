Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D8562086
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiF3QpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 12:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiF3Qo7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 12:44:59 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89453EAA1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2022 09:44:57 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8D92F76206E;
        Thu, 30 Jun 2022 16:29:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a214.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F25F0762210;
        Thu, 30 Jun 2022 16:29:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1656606546; a=rsa-sha256;
        cv=none;
        b=g6Rc7cs96fVc7E/heQfoRsmXE48/YQgx+IYoIgE1dULt8rRt/C8mCu3jF4MDf5xg8fKB34
        TSBp28fBVjebrXgnIld4dJXtV8GCzC0T0Hs7gE2GtLw2u4Ci663J133FCTYIFkR7ikRYM8
        ES53mdUZ3uZyIHhMh3AJeM93nVnfme9/5se0EhM4uapDX7QkN3l/14Rg+6gsaJo6yg7s47
        OttR2Q49gq86E8NSgBacT49br9O8znMxVYAefLOC/dgae7BTUmOAkN3z5bF5ORra7Z6jKU
        YQIZP3VxIC71juX4V5h2H2ShTvhtWkXUkMN2NVattdQg5zcvM67aKvPSquEkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1656606546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=9Sb1glpRpYA85hAE32jopfAa1TP5g8OZqmLv3plg0Zk=;
        b=Rhm4I7d4tiaKM6BLiv441UkhMLkKOwJaYbYdApGB71ko2uG0fz5odW5Dt+JCD+uHel1/OW
        xpwArZ6dMLSebBKoiU5upm3mza9q/XHPt9OJk7vu1L8RVEWX1WECO0ubbV7psYxQxk7HX2
        MM60ziTD6BTvKkdCjSJscsaBBlWAYi9WhuhZ9XbBwqfZx8t8T1OfRjy1FwIdCJPCmc9kbx
        6CwTzLCW02L1Kx8O3W0S2/L9LZM/+0BHQ6lgtdBJSl9239P0FV966t3Q9SzFuZDNY3eYwR
        1HuqsyNLiKzYxRuSt/kgW11bjR+b5C8JfS6ur7Wahe+ZNk5jx8bbPF+5NZ0/ug==
ARC-Authentication-Results: i=1;
        rspamd-689699966c-7cjd8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Army-Little: 2a18faf73aee121d_1656606546412_1698224174
X-MC-Loop-Signature: 1656606546412:1314743472
X-MC-Ingress-Time: 1656606546412
Received: from pdx1-sub0-mail-a214.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.91 (trex/6.7.1);
        Thu, 30 Jun 2022 16:29:06 +0000
Received: from offworld (unknown [104.36.25.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a214.dreamhost.com (Postfix) with ESMTPSA id 4LYkL86Nrdz28;
        Thu, 30 Jun 2022 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1656606545;
        bh=9Sb1glpRpYA85hAE32jopfAa1TP5g8OZqmLv3plg0Zk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=nnjlTuyuGFynXTWThk4sfTJ9a82f77dhLrXIaXH8hFYvhydWUv5cLlcfKNqwNZnbU
         zeStXr6xJnKjhYUtYjczmItscESH7yIhSmm3/FPSlwmmi4ualjb9Xz3ZTcjgj1iJhd
         2m1NHIV4dZSjL6OYOxa6vSnf2D5i9IVeEY7xz44NRHFA2Ajy4GA7nzTzZR74Qz57a/
         2li1pDID/zNQAHcpy7ew3WY0t8BMaJRQS/VgVnYXcTvDXCkBoyWw3lpYiLeyRPt5HE
         6d4FDewmA1OeTT2iGPyDw15I3qoiIcDCLLIjiZqffRdB+tHzzngRb1XajflB7CivLD
         LBLpRwWvBTeBQ==
Date:   Thu, 30 Jun 2022 09:14:06 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V12 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220630161406.yglzoxn2va3bhts4@offworld>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-5-ira.weiny@intel.com>
 <20220628153317.00002e36@Huawei.com>
 <Yr01iZhuG5YHThDg@iweiny-desk3>
 <20220630163240.00003596@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220630163240.00003596@Huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Jun 2022, Jonathan Cameron wrote:

>On Wed, 29 Jun 2022 22:32:57 -0700 Ira Weiny <ira.weiny@intel.com> wrote:

>> I _thought_ that we did not care if some mailboxes failed or not.
>
>I have a different view to Dan on this.  In my view if your hardware is
>not working in any way at all scream like mad don't carry on... Dan
>is keen to try to muddle onwards.

I am also of the idea of not carrying on upon any indication of failure.

>>
>> If CDAT is not supported on any of the mailboxes found then CDAT will not show
>> up on sysfs (as per Dan's last comment).  If it was supported on a mailbox but
>> no data is found the sysfs will show up but be 0 length.
>>
>> At this layer I thought we agreed to skip over these errors.  If a protocol is
>> needed at a higher layer and it is not found on any of the mailboxes the errors
>> should show up in that layer.  In this series CDAT is not 100% necessary as
>> devices can work without it.  So the errors were mostly paper'ed over in favor
>> of just printing error messages and muddle on.
>>
>> The xa_insert() deserves a pci_err() though.
>
>That's probably the minimum we should do.  The xa_insert() failing is something
>horrible going wrong in our software / host afterall.

Yes. And in addition, devm_cxl_pci_create_doe() should return any error status, and
cxl_pci_probe() can choose to omit any errors, but it's still better to have it.

Thanks,
Davidlohr
