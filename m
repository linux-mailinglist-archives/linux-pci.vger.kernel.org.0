Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020D65F42B8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJDMKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 08:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJDMJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 08:09:58 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D191263B
        for <linux-pci@vger.kernel.org>; Tue,  4 Oct 2022 05:09:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x18so8181168qkn.6
        for <linux-pci@vger.kernel.org>; Tue, 04 Oct 2022 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=N/GSbPnALToZPDvWcwsyZl8roxv+rx6jEvhzi+rz9/I=;
        b=RTneg+MYbqpdaR6DcxBkEgRYdkdGT/nADaTZZPJZhvDAxzQPMs7m0A2kPVP6DINta4
         WdfZUL4yQK8pw0FZOhVIXMhp1fk9pH+eJbK5Tqx+MCmSr1USpUcUoa7R9Rf1767wKqb1
         AeRT7DAaIvyy4+h7qUbsua/2q1lWUfWr4n+TbCX0HX1HBcT0mBFzdtKd3JHTz9AnLfhH
         se3y1acPQeJ/o3ky7rz4qZHWhvekWf7ycSpF/dwpQiZiZ45k5LLkwa85BGasVUKsIZ2/
         +1ligvmFMYMCDNKBgIb8Zn3ysy2vpPj5fsOfXsfI+ZJWoW2WSBrDTNTf40maeocKHdhU
         iPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=N/GSbPnALToZPDvWcwsyZl8roxv+rx6jEvhzi+rz9/I=;
        b=1/G4qBa6cUQh6jVkfAKwejKD/ze1OCJ/7P5SVIxXUwWt12u/CemZpxkQ1gnHNOIs02
         JI65J5TcfZOFV0qautPFAyrQykpgGectUz58uP2f+QANwXUDsLsVMc89a0gr1dBU3rIx
         3u2DVDuYFoFGPIRptF/D88C9qAMsOf1EJTfwvdmpv5OO8MuPOegkCB3OcFog7/BS+UhN
         SDGr4z5YoKAmrcDn3ZrZeIlTUer5E6WRvh0R/YyLTpj9cjJU2HS7ccsomIJy+9HvfPNH
         T5sdQ1dGamy6lRzGbqz9WmBu2zpX+M8T10gxXINOjUXCsWQmzUJpX+1OokyGxUYARcVq
         PONA==
X-Gm-Message-State: ACrzQf3xsySFL4AGuB5a3uS7Fnbh/D9FF97EgnEeOfAvcWIs01bXQ6C5
        /aRKuiQFmHm1YdwVkjlK26+vURlvfmTbSIYNvzg=
X-Google-Smtp-Source: AMsMyM4c7UWZ/P//H5lPCULKTAbDFoUwMbX5ucMGGKxbqR2LU0v5E3jI+fDVx+oI/2ieimLC7TISfpZGVdvQ82KOyzs=
X-Received: by 2002:a05:620a:2789:b0:6cf:ba4b:28a6 with SMTP id
 g9-20020a05620a278900b006cfba4b28a6mr16512923qkp.520.1664885393869; Tue, 04
 Oct 2022 05:09:53 -0700 (PDT)
MIME-Version: 1.0
Sender: ogunmasaadesola@gmail.com
Received: by 2002:ad4:5baa:0:0:0:0:0 with HTTP; Tue, 4 Oct 2022 05:09:53 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Tue, 4 Oct 2022 05:09:53 -0700
X-Google-Sender-Auth: CPg-5DdLWHcHlje9aOZfg9L4guc
Message-ID: <CAEGnpV_nFDhqoNfYNonfNb8thmP+=uz5Ck+p1Qaea=ZhV5Uegg@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 

Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply
me.
