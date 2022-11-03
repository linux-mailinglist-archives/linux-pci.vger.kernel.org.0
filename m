Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D27617372
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 01:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiKCAkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKCAko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 20:40:44 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319F2AEB;
        Wed,  2 Nov 2022 17:40:41 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1341D101431;
        Thu,  3 Nov 2022 00:40:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 51F5D100A93;
        Thu,  3 Nov 2022 00:40:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1667436040; a=rsa-sha256;
        cv=none;
        b=KLHov2jTCTyUBkCa2qXhQ48uBHJI5X79hpj87ZHK3qDJCotpKIfKdJUrPNVEfmpQYOiZQt
        zmSDYHLYEd4dbvJ7FzgVi4aDU/21vViqeQ92HbVpOOnE+Szn5ijE7TCELeDMcaOfp3RqR9
        KM0gA3e46zfXUKL/MCt/uPS4/cNSx85CKtL//OFJx1M8aW6IaZdgEQnbflCh3fcnjGlGBC
        HLGyujlOBLAvBgA3cMkvaYwDyugw3QCP5NCO3m3C4NVDHtXTB4s5xk4aIepP9QPR5rEW6f
        2WoRrf5nhF9FodtRjZaBumGJn25JvoTybNUf02EN8OsniO4uYpustWvMYn2u/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1667436040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vpS3mhEue3M8RKX/+6FKbKKv5EcohCrOAR91cRsHCBI=;
        b=WHpSlZUUoTyxvPG021boysiSRj+ZdlbyvHGwgjXcMVBGfbaeolft/0iK9jdLIiYZhTQbsJ
        0Ycli5PNNg27mgQqLFxOMvH9tUVjK7fSw2qO+n1D+a6CUCixM01iaiK2TlIcojOB6U52ks
        +lU+IFyEoqNofBjYLVscaMMRXdC7gCVMxszut3TYoXH+ApdH2c165YUXWDGTO0GM+pIP7S
        TOe1qfutMFE7pQaQjDA38hclmYINJzl9arALhT49+ehLdj5KNp44VjhFTJVvXAMmqEEXyp
        xwOEVyJ/VWvuPvDvhpQg83WCNFB8dZf0Bt4TjbT9KdfVeI9Z55Q39PAqakKrPA==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-b6m62;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Skirt: 2c4ff56e101fbf4a_1667436040713_4179043180
X-MC-Loop-Signature: 1667436040713:2622216607
X-MC-Ingress-Time: 1667436040713
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.77 (trex/6.7.1);
        Thu, 03 Nov 2022 00:40:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4N2lKg0msgz3T;
        Wed,  2 Nov 2022 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1667436040;
        bh=vpS3mhEue3M8RKX/+6FKbKKv5EcohCrOAR91cRsHCBI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=beRjdnFNqmKzYfnHS6fQulqGfsOIhHkx05NJiudJWN+QPO7VqLwXezQXIpie4vsXm
         m90+TvBer2m1vrgX9IUnmUeQ02T9WIh/RbrNQO7zEQQA1dPbnKQGbTCmngJ5+txo1O
         pbd3uGz38RyjmzQtaWUXay3qJ0sUZn0p0URHh+3uYwZ5vEHzP97zjJPSzXWT/Qeg5H
         IATns+JFepomjGjvkxBes3mh8ssMmRMmuQlsNYdagNXKtpKmi/1zm5FViDIxNdTr69
         ySNH5cv+ITNzLJm+P7SVj0QBW+N8ZSZF+QoDqPux+FMdNE5RL7dX/1c6fRV6DQaSpo
         aAlk+ZUZD54FA==
Date:   Wed, 2 Nov 2022 17:18:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
        alison.schofield@intel.com, bwidawsk@kernel.org,
        vishal.l.verma@intel.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221103001833.n2gsoflnji3pcsfr@offworld>
References: <20221024133633.00000467@huawei.com>
 <20221025232535.GA579167@bhelgaas>
 <20221102171524.thsz2kwtirhxn7ee@offworld>
 <Y2MAdaCES+aUc2QH@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y2MAdaCES+aUc2QH@iweiny-desk3>
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

On Wed, 02 Nov 2022, Ira Weiny wrote:

>On Wed, Nov 02, 2022 at 10:15:24AM -0700, Davidlohr Bueso wrote:
>> Most CXL features that can have irqs will normally use only the first 16,
>> with the exception of isolation (cxl 3.0), which per the spec is up to 32.
>
>Dan, Dave, and I were discussing this and we agree.  For now the only things
>people are working on are within the first 16 so why not just request 16 as the
>max for now?

It is a fair compromise, yes.
