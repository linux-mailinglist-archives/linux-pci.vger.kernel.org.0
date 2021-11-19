Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD1456F1B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 13:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhKSMyG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 07:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKSMyG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 07:54:06 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72351C061574
        for <linux-pci@vger.kernel.org>; Fri, 19 Nov 2021 04:51:04 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id t5so42626979edd.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Nov 2021 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=HAAO30K4kkkX/h9+P35xQ5fLsJTIX2g8t2+sx8sokz5fRZwWfcs9h5f/Ih22EtaR7E
         sgcJhfHzNaN2XiD5RZ+Q5oGAAiUU0S4AmieI+TFqV6X9HHg45OvFAI4fTdSB5vvgD1vz
         EPL0LfPuoivc0aI0v8tTwl46/qMZn6gwfMODw2CrqvB62Yn1Zfd/xH/yfDkMoJaVbe81
         NL0D34kDvnMZn9XlfbJKq209jU07z1RkLXebO+SKpUKqcNNjOq2JjTzQmKbpoX+XRzzI
         z5UvSBQfu8j8fJIGvSNHfU2Nsj9ZNDDnGGbQifjP4TqlgzLQeZzvLSUEu42L7EzhvAVx
         F7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=n06KdccdmRGqBFrQbeAZUSqyDy0ysAxfWVw+a36GrzGkgwiVSRVXjsr4XMMgRKR0o/
         a0kvaEaPI8XtSPo8sbcZkj3nmGpD2pr6Vv++Hfszs4FVnDeflTr0Uukq2GPawCsXGuaM
         sqFYSxdO1chXYyTebrLHTSn9sFoa0R7LzciLw5PySml9dqK4LFA8t/HmZzWSQdNL3BCb
         r3+dsNpz5Pib31ERPy02HuYRZT+WIvKWiOSJMVND2tRcwCupDGLgKbaXZKfPNutXvsDk
         bGmzqtI8ok6bYM8lxnb8csjjNBG92kF5Tt8biLRSOoMAk55ifi4FzeOWoKvpScKw2xOl
         nw8g==
X-Gm-Message-State: AOAM531dzLFQJMhE2LhEwOuH7wwZGyLaXmH6Z82n5ubA99d4jneKDZGW
        Z5Gj3jQ+MtmOG3luMbiLbXEVivpjv2dCxv+d2EU=
X-Google-Smtp-Source: ABdhPJzppEBocZcKwRwKDlYVElFs/oYyqy0wvWyuvBbE+FVLkHj0kweHWh1FLme6zh7HtgPLj+9rdvVbdrAVyHLStnE=
X-Received: by 2002:a17:906:cd03:: with SMTP id oz3mr7731983ejb.252.1637326262997;
 Fri, 19 Nov 2021 04:51:02 -0800 (PST)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: www.ups.usa01@gmail.com
Received: by 2002:a17:907:9207:0:0:0:0 with HTTP; Fri, 19 Nov 2021 04:51:02
 -0800 (PST)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Fri, 19 Nov 2021 12:51:02 +0000
X-Google-Sender-Auth: JNRhAcNQut4tDmkSBQnTSVUZPTE
Message-ID: <CABpS9gZnH7psw-oizVvBnXSuPsb=_J9jgN28Z76YBKq3vnUYrw@mail.gmail.com>
Subject: Good day to you,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
