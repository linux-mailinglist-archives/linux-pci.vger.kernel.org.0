Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41F6A6566
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 03:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCACTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 21:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCACTu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 21:19:50 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716EB445;
        Tue, 28 Feb 2023 18:19:49 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8AB7F5C0FA6;
        Wed,  1 Mar 2023 02:19:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a268.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C556C5C19FE;
        Wed,  1 Mar 2023 02:19:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677637187; a=rsa-sha256;
        cv=none;
        b=ep1OJunmZTR1AoHfFoHckXjCPu7Uh6soWR1R0HpfzuvCbeXXcPa2Yl1GTivBlmdYn1dZfg
        GqLsK/KDCNufPePe5NXTvof9kEJ38EuNvN9ZlTOrq9FMRXBjIIjwymqrwvcFtJhptflIuf
        iwVxYokbAcF/U4TZpO5GlOdfU/CIzIHvXhBpeZtcuInSNth8LZNmPISxm3Mxv7DXrR93eQ
        cpZYqbgrYkF7zyWs9jtr/fX4wWmRue7Y0IIQ/Yofa4IaOjKqST3yy6Qg18T1+xPAQvFWyV
        oxxdBsR6EWb6mq2ttW54mecLsVYtplBtBbKITSwRsGS4IjBvT5jWskMBafxuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677637187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=pBKVJ6yr5/sZu5kZRecYQTY7LbmCiGdwOZ6fa5VFReY=;
        b=iiDFEsfI85pLlxDl6VVGSj13W/ACJwJA6g4r/O1I7xTRETxJjHLkqc24wt05AAygfIXn0Z
        uDbk48FpwUNLMM6+4WwP70Cv00S5ZyXLTb2suvXKRzBLUrP7Aaw7933UD11xHGb0oRgcp+
        GQcJ+eO1gHs0ogtpSOQkoBjlBpyoxpQ/QQ8LHPyRpzEW/CDG0Vj+VgZeX7SA1wzhOcSvcd
        8c8OWDKr19whJnK8fcJL/MKyLGggaSJVDEFtb+rE3vz/72HB2lIScvEjkmpiqYzuSl4k7E
        5nLzs+/u0HROBgRrNdtaF5YNsp9sfsBtQSM57M42WYL7eYNbqep3Y7j9j7KaMg==
ARC-Authentication-Results: i=1;
        rspamd-69778c65cd-9csnf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Juvenile: 7efca3c96cec1d27_1677637188358_555531155
X-MC-Loop-Signature: 1677637188358:3277154009
X-MC-Ingress-Time: 1677637188358
Received: from pdx1-sub0-mail-a268.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.53 (trex/6.7.2);
        Wed, 01 Mar 2023 02:19:48 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a268.dreamhost.com (Postfix) with ESMTPSA id 4PRHxZ4RQgz9v;
        Tue, 28 Feb 2023 18:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677637187;
        bh=pBKVJ6yr5/sZu5kZRecYQTY7LbmCiGdwOZ6fa5VFReY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Ah0D6a4dhtjRnVTWjEVcgGYvFJxbliqO6ggVfDIhuWsqkwn576eVFBK0hAA5aZCyg
         br0StoADIIoef8SqNZjdFwd4mmH7Gx9LGkcJAln8aq5iwTySUTRJglvCd2X3tqPBYZ
         bn5jKpWpDCxBNfXJy9TNa135+AMirStXnbgPRrPP5dGB9+nZCNxgXV0j8e4qxhTSLV
         wyKfU9M/KlDEpCFUw5ElilqUAkGAyHdTnjbAm+ieHAmAZ0ptpU05EexHMMyE32RggW
         PA0ixQvuE/EPymXm5De5fB8zfylgg6eNyzuPwmATiYP9vhcW2rIDTdaLDj9Sa7cMOq
         uouZO1z/ikQTg==
Date:   Tue, 28 Feb 2023 17:51:05 -0800
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
Subject: Re: [PATCH v3 06/16] PCI/DOE: Fix memory leak with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <20230301015105.jnw3xqrhqjj23sfa@offworld>
References: <cover.1676043318.git.lukas@wunner.de>
 <53bd8006bae1385905eec702c97f66695363c527.1676043318.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <53bd8006bae1385905eec702c97f66695363c527.1676043318.git.lukas@wunner.de>
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

>After a pci_doe_task completes, its work_struct needs to be destroyed
>to avoid a memory leak with CONFIG_DEBUG_OBJECTS=y.
>
>Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
>Tested-by: Ira Weiny <ira.weiny@intel.com>
>Signed-off-by: Lukas Wunner <lukas@wunner.de>
>Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: stable@vger.kernel.org # v6.0+

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
