Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0298650A4C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 11:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiLSKoq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 05:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLSKop (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 05:44:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6079F5FC2
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 02:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671446637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hP40XExtVlEk3Tvp3942GEdX1ZWThCpbszcDu6IxWMs=;
        b=A3pbiATBWiRpMGctNlWvmXwCWOwU44EalXWQL7UTht9Wowgfz+RCRFcetEtqZ0o6KH80V2
        dLVIQj14lF/cYZYDPs3HIv0OizhzhwfKlmz4m7OsKTuVFrrlWFqfDscETaAnMgqaVS1X0P
        k/OzFbgZ8EYQSA7VNW2Cp4LTZkblPic=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-VuZnXIseOy2Av-IaAs-EaA-1; Mon, 19 Dec 2022 05:43:55 -0500
X-MC-Unique: VuZnXIseOy2Av-IaAs-EaA-1
Received: by mail-qv1-f72.google.com with SMTP id o13-20020a056214108d00b004c6fb4f16dcso5364177qvr.6
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 02:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP40XExtVlEk3Tvp3942GEdX1ZWThCpbszcDu6IxWMs=;
        b=iNnehoV1elYY3F6QO1DZVoYht9DMOkfVVspk5j5UnO6TcGRKIEgExLllDi0GEoMCB/
         Bs7U83Tw/aFzKoENpC59EN5GbAiwmDu3JAGAQRdFGXDEWkbKs9q4AC0IuQKRYoAzxNiB
         sxusd+ToD0wZ4YWDwJR3ew3WLIwDcHDg6yhAS3qAiTYfN8qlcOZiY/DX7SnE5JKgxHo5
         +aE1BDmWn6Z2elXRqrBL3q52MPr0VnNrxsVtAtE2bNwhPCmXLTu/kIsZiM+SMBN2fvur
         hIgyC8AKd40UZ6OV7bVC2lYSf9YPKc6HRg7GkvVpOLUwJk6KA1glnoUX0Y1ZPfQXoccr
         4x4g==
X-Gm-Message-State: ANoB5pnYQe/ZdxhReFx+vJfQqrDMoKeHWpTq3FNhP7UWivwRPT/bcLGH
        B5XY7ufP+X3dAV/vqKkzjlMJG5w4necwqYQjeKPlVSPibaF2sx8uxaFi3oGGF5EXvduPQrjVEQU
        PWqK5Odu7hPg0K8bXdhkn
X-Received: by 2002:a05:622a:5c06:b0:3a7:e783:7b6 with SMTP id gd6-20020a05622a5c0600b003a7e78307b6mr57457660qtb.5.1671446635231;
        Mon, 19 Dec 2022 02:43:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7E2KKhqSNRjJp5xUmcTvGusdp4XOxc8QsAeRjzIluNS2TOIJTGAX7KTyqc8UBeLHh3avNODw==
X-Received: by 2002:a05:622a:5c06:b0:3a7:e783:7b6 with SMTP id gd6-20020a05622a5c0600b003a7e78307b6mr57457655qtb.5.1671446634962;
        Mon, 19 Dec 2022 02:43:54 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fee9a70343sm6618272qkp.14.2022.12.19.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:43:54 -0800 (PST)
Date:   Mon, 19 Dec 2022 05:43:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221219054321-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219083511.73205-4-alvaro.karsz@solid-run.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 19, 2022 at 10:35:11AM +0200, Alvaro Karsz wrote:
> This commit includes:
>  1) The driver to manage the controlplane over vDPA bus.
>  2) A HW monitor device to read health values from the DPU.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

As far as I can tell patches 1,2 are upstream right?
So you can just post patch 3.

