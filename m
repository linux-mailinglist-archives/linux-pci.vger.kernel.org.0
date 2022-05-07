Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF851E314
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 03:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445210AbiEGBiY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 21:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445193AbiEGBiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 21:38:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4085FF0C
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 18:34:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j6so7137285qkp.9
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 18:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zThBLjiNsJCeKFFlhe1rfqlDr71g2WujQnHwvs4lPvQ=;
        b=cnnmTvdiFiJlA1KHKlWizOlqgzOyaYfTiY5rGb5u2xg7fz94vKshHcZwcHKwdIT3lG
         bEToF+k9+HkdLYhtzSp808Bd5iNJytHYdrW8lEymf7KFXZs2EJ6HbbHypueVlSPQKyFk
         ON417m9gya143SlwI2D5gAYo8JIiNCRPvqTSGCNCIecmjwglMeUFhS55RMKzcA6Ta+6F
         D+XwyKoKMoYdZeNHbVEoNEWk0RU3BzX/xL0eumfvE3vyZmYuf8sXXVAFDcDd6XXu6oLT
         ngxAmja5WO6R+XJYJV8E0VHq/uA1gCTRKKYmwloK01Td1clNFEnImGAWq/iCwX9XIxk6
         TYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zThBLjiNsJCeKFFlhe1rfqlDr71g2WujQnHwvs4lPvQ=;
        b=P0t1hVPF5EGP6NOo/SgrSaAKIUoBGrLsi+joB+Ah7NTAWW+0tuV5BWmNJXMhHyuAsx
         tSYW5DULspH/ZSZQHsFgop4q9hMTx4GmvkVwxU77qiQkR0GQI9CkKM53Lo3uYobqEvHF
         Ul3WEgBvRQTSqwayXOPuLcaf1APB3XvU1W7LhDFPk84SUS/kWseY96HY8zZMawkH1Oy+
         qN+R17m0Xy66myNnae/WLFrCGIlyujKg2xdpWXX7TjNPsMN9SJQK6C6bV4j6CO5NTr1P
         2XBbokGr+fSJUkVWjDYFkMMguaIRaa6kmaVJQ6CRu3Udrnkp0dfIoLAwm7LaVeSbxz+J
         aBTg==
X-Gm-Message-State: AOAM530t7Y97vw9586k9KLLd9yVndzAW6lme7+a5QM6OcNwyVcCgottG
        Fiko28QFCA2XepLNeyBIutcMnQ==
X-Google-Smtp-Source: ABdhPJy79gsfVlLMNpSVrQumWl+7nsmo4IRnzXwP0HzsnAheLZXd5e+jHFAOnraCXjJB7smkog8HDw==
X-Received: by 2002:a05:620a:c86:b0:69f:c7cb:935a with SMTP id q6-20020a05620a0c8600b0069fc7cb935amr4446672qki.229.1651887277670;
        Fri, 06 May 2022 18:34:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8518e000000b002f39b99f694sm3460795qtn.46.2022.05.06.18.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 18:34:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nn9LA-002jCW-1X; Fri, 06 May 2022 22:34:36 -0300
Date:   Fri, 6 May 2022 22:34:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <20220507013436.GB63055@ziepe.ca>
References: <87a6bxm5vm.fsf@epam.com>
 <20220506201722.GA555374@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506201722.GA555374@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 06, 2022 at 03:17:22PM -0500, Bjorn Helgaas wrote:

> > Modules linked in: xt_MASQUERADE iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> > nf_defrag_ipv4 libcrc32c iptable_filter crct10dif_ce nvme nvme_core at24
> > pci_endpoint_test bridge pdrv_genirq ip_tables x_tables ipv6
> >  CPU: 3 PID: 287 Comm: sh Not tainted 5.10.41-lorc+ #233
> >  Hardware name: XENVM-4.17 (DT)
                ^^^^^^^^^^^^^^^^^

> So this means the VF must have an SR-IOV capability, which sounds a
> little dubious.  From PCIe r6.0:

Enabling SRIOV from within a VM is "exciting" - I would not be
surprised if there was some wonky bugs here.

Jsaon
