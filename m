Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299A244D5F2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhKKLlV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 06:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhKKLlV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 06:41:21 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400BAC061766
        for <linux-pci@vger.kernel.org>; Thu, 11 Nov 2021 03:38:31 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t11so11331168ljh.6
        for <linux-pci@vger.kernel.org>; Thu, 11 Nov 2021 03:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rZ+iNUqHapDy2raiwGMjoJiCC9fkv5fXib9X5u3Bt2I=;
        b=kCEag7ZJe4HS8md4tRrY1MXRla2lHM/u3AeSJOi0eP2FTKll0XSjL2bevfdzonkauq
         4ZYtKkF6kCZeVlYeqCj+GH0EbNB2X6n3br+D5EPrvwmfL5279jbbaHZe8gbqLLfNzupr
         k38vpvZEr+rEs9/jlZhyIyfWzi/1RVn4yG8gCpRUW7jGL0yT9bEj1zNTWF4dPYosHSJr
         xQ786gpDAsR0orw4vKRa1Urz1oJA2h2ftATIvLgEM+ECRTuu4g3yEaQ7O4++ypJ8/vZy
         QUaV/ofMPugSwyPQRa+mNM3+KX9e2EqZSJqaSiFspFd0K2jE2wW/V44rfoA7v+WmKevG
         ZNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=rZ+iNUqHapDy2raiwGMjoJiCC9fkv5fXib9X5u3Bt2I=;
        b=UPQGtEGwBrCqVuVNaw2h11apJ30THmmRyE7/FuHLa0PQwTB5MHBUa9RfsYm8jrjq7P
         961J4ADLNQhpy5C/uYWK7Fm8AslKgtvnya9yZB2QXQDDZrrbRwMtYvglrA2ZXqYeKi7U
         RqevDIv5XiSMAioaYn1HeeSUcIhiD4uuyAs3ikSIzQWhxc4yYHIn9HuYRONzZMW2POn8
         TOfSWJxJcO1r/KqUl3LCZZ33po7L3fBev/dtGtefqCFnvKgSNQCzCqXcBb+DJViwIqbI
         g5Rhucy8PtxDeavSD1wpCYtpZJ+SvujqlorNcuy/RvieQImKd+O6Gis19rqy5o0VQ3X0
         0LgA==
X-Gm-Message-State: AOAM530nhLG5Rso5L1PWjXtfACve/w5nEcxu/mujOsXeqipZwuVJPJYb
        rQfhbJvCb/EEor7QBTG7W1CEycYpDl/nWMEel6CNYk8YF9w=
X-Google-Smtp-Source: ABdhPJyh6vdSy2W3AGRaY1JSXHTZD4m8ma+jy6qgP/yj8W2sNcFjXFISAjipOIlNTiFCdLU+xpa8iFcxXRH3ZK2CI34=
X-Received: by 2002:a2e:3902:: with SMTP id g2mr6522736lja.321.1636630709695;
 Thu, 11 Nov 2021 03:38:29 -0800 (PST)
MIME-Version: 1.0
Reply-To: sgtkaylamanthey@gmail.com
Sender: sonhayejacquie@gmail.com
Received: by 2002:a05:6512:1111:0:0:0:0 with HTTP; Thu, 11 Nov 2021 03:38:29
 -0800 (PST)
From:   Kayla Manthey <sgtkalamanthey@gmail.com>
Date:   Thu, 11 Nov 2021 11:38:29 +0000
X-Google-Sender-Auth: ogyUNijnPcgdJZptHjEcuR9lNU8
Message-ID: <CA+W5SuhrXj=GKnz3SxEoGOXBHK2RqN0KBuU8oOr7ydY22sAk7g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

=C5=BDivjo, si videla moja sporo=C4=8Dila? prosim preverite in mi odgovorit=
e hvala
