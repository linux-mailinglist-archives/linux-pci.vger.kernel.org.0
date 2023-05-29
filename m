Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D2071440B
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjE2GQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjE2GQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 02:16:35 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A2C6
        for <linux-pci@vger.kernel.org>; Sun, 28 May 2023 23:16:06 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bacfc573647so4365019276.1
        for <linux-pci@vger.kernel.org>; Sun, 28 May 2023 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685340963; x=1687932963;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=jmjP9j++MRBLdN8rfr+SqJTV9f1XKJdeCPimoc4lPKYVpw76K+XJIQsYAtdrA7gF4n
         1SaJbICc614D+5TJseSaIuOCtYVo8VoIrVnXgsdf4+kCN4/sTzY0lmmzNlwkDN06S3KX
         UAc3Vetup5ocJf3t46getpJbmyFFL31D/cS4Q7ZYc6BWAblARgfaab7mCyzZL5fo6Psr
         P0SX549xKpDAXZo6zA129lHVS/1OcgpXJrCWPDsqGFbibM5j6RdIKWAZBPVJ8JA891Iz
         SVvWjSZybG3RdHRqibagmzqSupd2lFtkMFthM+y/7Am/kX9dcJmVFGYTMSf0ZeFwq4kf
         Jrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685340963; x=1687932963;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=IwzXOwDdJcWZyWu67fCdiI+QKf6SeJ6sneahrRmcVXwGvcp+zJVwFGaRbkDXUzqmiI
         TZ28Qi13KOJGT/johBy+UxXspaDssxU7ySNybTp9DbtLxRKU6DIToNaYpBwhRmhKNg+o
         lhKmTE2OqGAWLPVaaATi22iWEkauu0XtZ3cpCK889C4k4jrRIgHer4viiovrBIEzQFsV
         D+OXUzeL1Sr4W9zpRdIIfMXsTKn1LnsaX4vAyK4jX0de9sT9SYcKrP0qRcLU51qoBfRa
         mH1YF2/b2bPdMl0K7/s9MJfQqD468bfyqGiB9wmlt4bkAlw3w7MedsoGZWB4Aeb052pM
         6tPg==
X-Gm-Message-State: AC+VfDz7qKrv/MDQ4RPl2K2cQfeYOKvVAlrGQtzswc6c88OOKJEBVdcG
        +5Z7DhIgzd+u8RnnVM7Wl89WnGMeH5Yb9BmE/TE=
X-Google-Smtp-Source: ACHHUZ5mER2Rzdz2RWP7zak3yY0eQnK0yqG8LbRLfpq+ciuwMKRNQdgcbF6LmTRnUnZfH1HDD+rlc8rVb6TIe6jouiw=
X-Received: by 2002:a25:4148:0:b0:ba8:1e01:ead5 with SMTP id
 o69-20020a254148000000b00ba81e01ead5mr9430746yba.60.1685340963536; Sun, 28
 May 2023 23:16:03 -0700 (PDT)
MIME-Version: 1.0
Sender: mrderick.smith2@gmail.com
Received: by 2002:a05:7108:5386:b0:30b:2a5b:30b0 with HTTP; Sun, 28 May 2023
 23:16:02 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Sun, 28 May 2023 23:16:02 -0700
X-Google-Sender-Auth: WmBFA3qCmfVyriCgQimHjX2virg
Message-ID: <CAO-9xdkGmDRhnyb2T0xHjfLF0efFvD28KsjZzXviF2ua5Hfw7Q@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
