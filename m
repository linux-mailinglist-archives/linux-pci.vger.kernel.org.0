Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74365650A88
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 12:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiLSLEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 06:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiLSLEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 06:04:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100526FD
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 03:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671447846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HFU8kays3P6TY4J+vE9PvJg8dI00vA5z+YC53FInzgk=;
        b=LothAIOMqq5KmALCQ+2N1AR7Q0HGdP5/BaCXIZKQv54aSmBEUfAGvNHl1ub/+AgVQRi2AJ
        GpjnJzDwtSxi102Z/ou7IivWzlKPTPpOqhuEilxT29Vu2smyPXiz3aWYPOsWwUpQiXcc1o
        I4Kxz+2jcoXT+06QzHH4ABQlq8vp1nw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-BDu0xycCNmqfkj4AWplJXA-1; Mon, 19 Dec 2022 06:04:05 -0500
X-MC-Unique: BDu0xycCNmqfkj4AWplJXA-1
Received: by mail-qt1-f198.google.com with SMTP id n26-20020ac8675a000000b003a97d74d134so1609905qtp.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 03:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFU8kays3P6TY4J+vE9PvJg8dI00vA5z+YC53FInzgk=;
        b=c1CdDsTMN18F0dVHPWxYhovRDOkrBVhvoF6FaVm60pZGV40QKpXyWW+ADiXah0gwjr
         yRoeANKd927cQDHhN0oBodWSaJxWzrW/ub8r2G8Xw8IOBFOi46BzmZAwEF8Oo0UAxBHV
         JtrWe+UyatKkfyZXdd3u6SHaNYyRonvvSV/QqYQe0iRBLAel5P693lziasE6wb3ZBzUJ
         HspXyiABiynFRBJfCvLHFYzNdduExBrbJoPqbdHmA7gO23EQRYA2qTy7XLnkIy0pMtlF
         a4/FokN9fT7S68/KNDXB4ULJBdHkic7onopPeH3otZrnyhmuLvsPZZ4SLyVyk+LRqgix
         WWcA==
X-Gm-Message-State: AFqh2kpzS88/dZcDNx4wSQhbqjR5txJIj2vOFzd8zIbon0mEaPrW++uF
        x3Bbg9EfJJ6d68DCLD6oxPm9jxI6JdC2uOxILrcXZuHzBwlDSo1N0dJG449TiYrFHESTvm6+7xb
        UKtCirPUwZXJPQNJVyiSJ
X-Received: by 2002:a05:622a:5c87:b0:39c:da20:602 with SMTP id ge7-20020a05622a5c8700b0039cda200602mr14663259qtb.12.1671447844715;
        Mon, 19 Dec 2022 03:04:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtpZ3T/fTyuYoCeJGeHnvVExHiT5qqMEWOXtZlMAViLpfhcHqxU5KbvEr1y4ZuyR4lkv//1pQ==
X-Received: by 2002:a05:622a:5c87:b0:39c:da20:602 with SMTP id ge7-20020a05622a5c8700b0039cda200602mr14663237qtb.12.1671447844491;
        Mon, 19 Dec 2022 03:04:04 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id u14-20020ac8750e000000b003a70a675066sm5774006qtq.79.2022.12.19.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 03:04:04 -0800 (PST)
Date:   Mon, 19 Dec 2022 06:03:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221219060316-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <20221219054757-mutt-send-email-mst@kernel.org>
 <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 19, 2022 at 12:55:02PM +0200, Alvaro Karsz wrote:
> > could we add a comment explaining this trick please?
> > can be patch on top ...
> 
> Add a comment where?
> Do you mean adding a comment in the change log?

Right here in kconfig file where the trick is.

