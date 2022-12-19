Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810F165109F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLSQlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 11:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiLSQld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 11:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15F2ADB
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 08:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671468045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alI80azai2J5zn//yXaYO+UiKyXyCQg9u2KyOPNuKXg=;
        b=I4wEXvFubVwYWGPgg6/PeRXLxixrZpQ3lMh7yaUki1KvdXAaAdS6ELsdlZV+GW/Rf9erpg
        w+KVqUXg2UX6iYGrok2aki1g1U3T9v3BCV6RJoqaLsRDL7dMm2aw5wSfMLM8jHN/oCmmAz
        tLVauPsw7fnxZdMdVSMllVH1h/bSW70=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-NlY4e_xzOp6wZI8K94RLpw-1; Mon, 19 Dec 2022 11:40:35 -0500
X-MC-Unique: NlY4e_xzOp6wZI8K94RLpw-1
Received: by mail-qt1-f200.google.com with SMTP id v20-20020ac87494000000b003a81928b279so4233383qtq.21
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 08:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alI80azai2J5zn//yXaYO+UiKyXyCQg9u2KyOPNuKXg=;
        b=UX9H5YNCNCj71OlYXY/x3BpwL6KljGxAD1+5ATp9q01TFLBkZi/6wMvGTcM53c+A99
         yh8cVziJadIdaYJKYy1q+EuZN2ppwsXxekQiHFZgfdkxIo9xYYC+XUr/wpEV43/UEUFY
         BsV7ZsvKXFxGxY8DpDn0ZQD6F0ZRj3KZK7Qg+xUimrbD2xUKoYLr0u4xQL5oodmvFKgY
         VR4sHSnb0xqKyACMB/ovctDOLMEOCwugxJIknxenLFe8qc/r6TG3DXmi455o6gW71E55
         kA1udQNUX+NpX0mwloT6/4g2Fs8knktBvE3sfTkGAcII58IELdXYNAKkU3hh5CDeexH2
         FgOg==
X-Gm-Message-State: ANoB5pmOvXXohMYLKc22cyyjER1q13hTvfWCH08rBDmj+5W9AyRsK43k
        LkPyHIQFoh4HK5JDAZX81kWYFqBFzk04sJjw/bol/Mo36KgEPI8N69eOHrdVmg7R0O7xfJ+LQJd
        SlU50Nu4bjJW6Rt+IB0H7
X-Received: by 2002:a05:622a:4ccd:b0:3a5:ad81:8aff with SMTP id fa13-20020a05622a4ccd00b003a5ad818affmr58808995qtb.55.1671468034677;
        Mon, 19 Dec 2022 08:40:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4FrQraq3UtEHtW8UljHw+/l2F5pAMPXM6Tg5qBf60TCPkPzgq0iUeW3Hv7LHs6MbLbNG+5NA==
X-Received: by 2002:a05:622a:4ccd:b0:3a5:ad81:8aff with SMTP id fa13-20020a05622a4ccd00b003a5ad818affmr58808976qtb.55.1671468034444;
        Mon, 19 Dec 2022 08:40:34 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85693000000b0039c7b9522ecsm6241119qta.35.2022.12.19.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 08:40:33 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:40:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221219114024-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <20221219054757-mutt-send-email-mst@kernel.org>
 <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
 <20221219060316-mutt-send-email-mst@kernel.org>
 <CAJs=3_Cq3ca=evn9J=mQT3ieF0wi2YVfjfgJ3Ykh-Adu7Fxujw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs=3_Cq3ca=evn9J=mQT3ieF0wi2YVfjfgJ3Ykh-Adu7Fxujw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 19, 2022 at 01:32:22PM +0200, Alvaro Karsz wrote:
> Ok,
> 
> > can be patch on top ...
> 
> Just to be sure,  you mean here to create a new patch adding a comment
> to the kconfig file, not a new version for this patch, right?

yes

