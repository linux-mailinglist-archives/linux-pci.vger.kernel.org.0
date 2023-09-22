Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749CC7AB1E4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 14:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjIVMMf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 08:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjIVMMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 08:12:33 -0400
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FF99;
        Fri, 22 Sep 2023 05:12:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
        by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id E476E620D0;
        Fri, 22 Sep 2023 15:12:21 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b66f::1:2] (unknown [2a02:6b8:b081:b66f::1:2])
        by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id KCKoP90Oqa60-2zgabs88;
        Fri, 22 Sep 2023 15:12:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
        s=default; t=1695384741;
        bh=r/0m3uzopfRvU6zFxR0Cy81RmqseUwpTjIh/9t81bXY=;
        h=From:Subject:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=M6B/oK6VZ64gGBNHlnMmlXvHa6y5soNRe3XOWtzLcvLUde0RrT9OZS3HyRa3NyjNO
         qUVeqdSbOZ5wEKuNm2E+dnRK8nch2VsLiDEcfzyKIE6Vlm5LaVJJGjqTpmhnEsC+7/
         MBmCC9QLajnHLARDjSwFV287xNpZAG9wOjmfKTmE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <7f741384-d1ce-4ed4-a7fb-95fbc8b2971a@yandex-team.ru>
Date:   Fri, 22 Sep 2023 17:12:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     valesini@yandex-team.ru
Cc:     bhelgaas@google.com, dan.j.williams@intel.com,
        daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        rafael@kernel.org, tj@kernel.org
References: <20230922120645.65190-1-valesini@yandex-team.ru>
Subject: Re: [PATCH v8 1/2] kernfs: sysfs: support custom llseek method for
 sysfs entries
Content-Language: ru, en-US
From:   Valentin Sinitsyn <valesini@yandex-team.ru>
In-Reply-To: <20230922120645.65190-1-valesini@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Obviously, the subject is meant to be [PATCH v8 x/2 RESEND].

Best,
Valentin
