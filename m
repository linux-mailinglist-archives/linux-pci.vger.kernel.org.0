Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06AC539566
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiEaRZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiEaRZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 13:25:17 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B58990CDB;
        Tue, 31 May 2022 10:25:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 88C0D21D73;
        Tue, 31 May 2022 17:25:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AF12121FBC;
        Tue, 31 May 2022 17:25:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654017912; a=rsa-sha256;
        cv=none;
        b=cxqqB8RqZa/iqtbv3opLLeabodEeIzywVNEUnNzM4n4IfUQJNoA7hMkTMU57az/ZGVAVtJ
        2vCpnYvpzJsz3TeZYJ86V8zHGVVO9atnK2OjYkS1YhFs76mBQ/JBJ1facXLqxfDMNgAnRo
        rqf91E20yFPaFZ6/GeLmeJLHWe5MMJ0a0UX0XIp0W9ln9PPUL8AIWFoxxmJLW0rXynycRz
        kkpSKpNBMaTaXd54BObZEold1tVrLLD2ziqnfYDTU0+aQhkZDHCTlb6v6Adv2n5asmarm0
        4VhWJr7zEN86FP84PHZCE1dlojgxHeQewMHyPjuLcO/dMHQtjPPimx76vbwc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654017911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=r+iCa0G+5l2oLU1hDQ/hBTD6TF0JVzAdaVROMvYsjVE=;
        b=4TTVmdGiPIRoLS9XG4JT7NaviDgGlfKfE04QrOUnkHp33gh27z9updHaqU5gR+A4J5ZTG3
        poxHLaaORVYaPpbqS5+uxQJS+1pC7y7jukTuYkBxgt/nSiOoNK1h/JHz+WTsQatOVXpBOR
        aeAlDPVq3ccE1iTLKLeL24LmNIVj3/ZvSZ8o+zOHuLtvjBY5gtg9MfzSjTQ+7xn0tZopLk
        FKCpzypFJ6FBES4ir3oBkG/bRVICi9DQ/Vx4ETRclH0OurIyxHha81vHPTlQe8fJfhKRGO
        ZkHqqEzS8cEmrjfSZWrIyAan6WDIig2uzeRCFZAEYBEmPATfZkisn/UYe3GLUA==
ARC-Authentication-Results: i=1;
        rspamd-77f9f854d9-qwfs7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Shade: 0915ff0469342c1d_1654017912229_2223760134
X-MC-Loop-Signature: 1654017912229:940560900
X-MC-Ingress-Time: 1654017912229
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.93 (trex/6.7.1);
        Tue, 31 May 2022 17:25:12 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LCK0k4vtNz3H;
        Tue, 31 May 2022 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654017911;
        bh=r+iCa0G+5l2oLU1hDQ/hBTD6TF0JVzAdaVROMvYsjVE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XnO2M8HGW2PIyFH2/jOoBnuxVxx3UQY8Wxz3K+c1Evlx/w4aVVgXSTgWvUcFJBwj+
         md+dndlhRZu127yWldNWwDFRWWyb21PiEp8LAgFm6QWYaWG7zU1PMhP64LXjJBcy2B
         uDeUTIcKCD1BkCWA6PT9GjVA4fh3cIgmv51ycKt12PN7Qnpyeu/NVQDQk8ag/dOalu
         km0YOD1WKToOk+dQCTgl7o663ZvheqEHhHXVvbjmnNume6BwabmrVjuTv+00SkGnXf
         QqkjXPTbc32IkaAmhSE5JCSQTOsgNmqY7cHKQt2I6EBKxRHMUe+YnqVSRkdS8feb5+
         YjV7jQ0SdrYLQ==
Date:   Tue, 31 May 2022 10:25:07 -0700
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
Subject: Re: [PATCH v9 3/9] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220531172507.5ert5tgwellpe7fx@offworld>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220531152632.1397976-4-ira.weiny@intel.com>
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

On Tue, 31 May 2022, ira.weiny@intel.com wrote:

>+static void doe_statemachine_work(struct work_struct *work)
>+{
>+	struct delayed_work *w = to_delayed_work(work);
>+	struct pci_doe_mb *doe_mb = container_of(w, struct pci_doe_mb,
>+						 statemachine);
>+	struct pci_dev *pdev = doe_mb->pdev;
>+	int offset = doe_mb->cap_offset;
>+	struct pci_doe_task *task;
>+	u32 val;
>+	int rc;
>+
>+	mutex_lock(&doe_mb->task_lock);
>+	task = doe_mb->cur_task;
>+	mutex_unlock(&doe_mb->task_lock);

Instead of a mutex, would it be better to use a rwsem here to protect
the state machine and allow for concurrent reads for the work callback?
It is a general interface and a trivial change, but not sure how much
performance is cared about.

Thanks,
Davidlohr
