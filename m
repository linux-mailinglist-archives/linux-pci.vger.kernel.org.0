Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EF1748320
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 13:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGELot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 07:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGELos (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 07:44:48 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183D11737;
        Wed,  5 Jul 2023 04:44:46 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6b5f362f4beso5587548a34.2;
        Wed, 05 Jul 2023 04:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557486; x=1691149486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGmgNZpQ92H8RtcLdnvOqptQIs6xEPnLECzACgHGwvo=;
        b=HiowYq3lg9oMHzy++NIwbhtmksQpbsNvzlMeq3JrLquCFaCtFT8LdoPXc9ikxzMER4
         n4j37derF4/DnzHAGit+UIBBcmVUg5jEY+fzkQdPilJTeogLW7UA1ospn5ZPeXh8n03F
         ZfTeHJ32PbGgRBSX/b0IoaLxrx8zS56lmXLoeDnUs6qvIPK0pyh//Qlb8lV/k5xeMkQp
         ZZbfffu0yIhS1+E1ZxhN8ou1OlSWxHe/aS8gFsXXcRbokJPIxv4eAYi/BFB1G+RsgEMx
         eWa+DNZlvaWO9Ts59JVB5dVhtuMzGJdQeh/v5FhheEGehjoIVo+f4qYjBgXRohy1/1zq
         mMjg==
X-Gm-Message-State: ABy/qLZbOP3cgjEkGNVYbpVzGcm7l/+6CVzlayo7gZyyhykd5RW0cnxK
        oagq8tukqCQDGmc/mkhIGEtuYwKiKrd9PDoL
X-Google-Smtp-Source: APBJJlE29szK4gZbcjRGLGDhf4x+ZEWEI7JwaN0ovkUsopslhaFgGeEKb2mbAqRj8q+ENlQbRP+q/g==
X-Received: by 2002:a05:6358:cb2f:b0:134:e413:4d3 with SMTP id gr47-20020a056358cb2f00b00134e41304d3mr11341085rwb.16.1688557485856;
        Wed, 05 Jul 2023 04:44:45 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id n9-20020a635c49000000b00543e9e17207sm17920311pgm.30.2023.07.05.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:44:44 -0700 (PDT)
Date:   Wed, 5 Jul 2023 20:44:43 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com, alistair23@gmail.com
Subject: Re: [PATCH] PCI: rcar-ep: Include linux/pci-epf.h instead of
 linux/pci-epc.h
Message-ID: <20230705114443.GA3555378@rocinante>
References: <20230705104824.174396-1-alistair@alistair23.me>
 <7536d9a3-4738-2bc2-e33e-d93347893865@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7536d9a3-4738-2bc2-e33e-d93347893865@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> > pci-epc.h doesn't define the members of the pci_epf_header struct, so
> > trying to access them results in errors like this:
> > 
> >     error: invalid use of undefined type 'struct pci_epf_header'
> >       167 |                 val = hdr->vendorid;
> > 
> > Instead let's include pci-epf.h which not only defines the
> > pci_epf_header but also includes pci-epc.h.

[...]
> It is odd that the the build bot did not detect this...

This is a bit of a surprise to me too, especially since none of the usual
bots pick this up, and I can't seem to find such a failure in the nightly
CI logs either.

Alistair, how did you stumble into this issue?  Also, which version or
a tree would that be?
  
  Thank you!

	Krzysztof
