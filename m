Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092427AB476
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjIVPKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjIVPKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 11:10:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38890CE;
        Fri, 22 Sep 2023 08:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB982C433C8;
        Fri, 22 Sep 2023 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695395423;
        bh=YS1VwNUPD1Beqy5jfkE9Qg2khTBXJoIGUKn56lLraQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJFqN39U2QRlykBCfpke5oY6v5TW/dLBIPzCtirzPAGoiW4yj9xQU8SlcHXPYoRhK
         cmr7nAsWmqqkV26QRMFwBZvjJ8DFXYJbZdrpMTpcuk1HFjTPIddYRsgNQdkyNL2n6o
         mqxU43+uQqwC+8dtxmO8qLp4H5P+6e/QnTQ6m7To=
Date:   Fri, 22 Sep 2023 17:10:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Valentin Sinitsyn <valesini@yandex-team.ru>
Cc:     bhelgaas@google.com, dan.j.williams@intel.com,
        daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rafael@kernel.org, tj@kernel.org
Subject: Re: [PATCH v8 1/2] kernfs: sysfs: support custom llseek method for
 sysfs entries
Message-ID: <2023092241-obedient-squirt-966c@gregkh>
References: <20230922120645.65190-1-valesini@yandex-team.ru>
 <7f741384-d1ce-4ed4-a7fb-95fbc8b2971a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f741384-d1ce-4ed4-a7fb-95fbc8b2971a@yandex-team.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 05:12:19PM +0500, Valentin Sinitsyn wrote:
> Obviously, the subject is meant to be [PATCH v8 x/2 RESEND].

Can you do a v9 then please?

I am behind in catching up on patches due to the merge window and then
travel, so please be patient.  If you want to help out, please review
other pending patches to help yours move to the front.

thanks,

greg k-h
