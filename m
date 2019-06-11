Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF94A41641
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406545AbfFKUlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 16:41:03 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:41245 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406534AbfFKUlD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 16:41:03 -0400
Received: by mail-lf1-f45.google.com with SMTP id 136so10329642lfa.8;
        Tue, 11 Jun 2019 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+OJzxnVVS4wFBH5DiIDtUenE4vBkJMY2VUfbvoqpns=;
        b=VS/A3Jsn4Dr15+vJ0W/x5B/BN5ErFMnY2iyxk6jVq5catJdkbBCd/KTO6+wQzrgJdy
         r6iTP0ytSh4h4sitbHAUjnDZfSzuD6yhAjQZ8NhV4ggVjmkzedh8J3/kj+tc9YmnHaw+
         SrMVptHKvVtixZkDJGXIXDQAhuAR+A4IN18ihHMWkBzxRxNdHRTONhfDNAJlrnX8BL3V
         wA+HIby9c4LFJ6gmDNHQ5Ay6lRHDLxB6Uqta4TAnx3Uk7bFsANtgnKNs2yg2mjCVNYns
         C2LK4VbBh7FFjx2SNMYM2km1CAsMslNy50h4kXjTU6BvLhaoINlwQTKravJUS7Td+wLk
         EQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+OJzxnVVS4wFBH5DiIDtUenE4vBkJMY2VUfbvoqpns=;
        b=q5mPecZBQPOu40KCAtiPhN0KJ3kHsTuNKFXbeT+NBKFhlLmBWJeEYii4jwG/ek9bKs
         /OISgJyO85dqT7kpO+0lU5fqHcfASpkZa4m/QYzS/eVEZuW1uzhu0Xxr7bOarr3fpaS+
         YsOkFDJ5j9eknccGosXo4C4DFdogKAInUAWaN7+Td0HAkNOilLZZcUriPfKeYaMwUELQ
         MqTWzJ18ZnBlAZfFYUWVKHkTdOWGnhWT051M2wL4Mydn33cT+zD2Q05pw/LK5sQCTSOj
         JsSGwBO0cg+HnD4irmkK9Ufjy0Vw0ElsE7W8gp6zB7d2dl1V0XUHfVM6B12cHhcB63hb
         HhDQ==
X-Gm-Message-State: APjAAAWb887L90WEXHaf++2vdTTWJJtSGzqeA0L67SPeAnGvTiWKfq66
        82sIGDAE8RsevzSXu2AIWb2VSyU2Wg/1ytqLNKs=
X-Google-Smtp-Source: APXvYqwjW6c1BkP7ALFbfOw4CqwKcc3q81d+wGnY8WlggXC38uBmHOizOqMXlMlcsQvw/hmgtUavxUE0mQLFnFYwYNI=
X-Received: by 2002:a19:5046:: with SMTP id z6mr12181932lfj.185.1560285661059;
 Tue, 11 Jun 2019 13:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <f297c15c-af4f-e4b3-feac-ca313f46f13e@sedsystems.ca> <74703679-96d4-b759-a332-c3f3bff9a7c7@sedsystems.ca>
In-Reply-To: <74703679-96d4-b759-a332-c3f3bff9a7c7@sedsystems.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 11 Jun 2019 17:40:59 -0300
Message-ID: <CAOMZO5C9fu_h5Ct-rbSuTQ149JFT6tH-iN_r8dnYaDxE7gL+UQ@mail.gmail.com>
Subject: Re: iMX6 5.2-rc3 boot failure due to "PCI: imx6: Allow asynchronous probing"
To:     Robert Hancock <hancock@sedsystems.ca>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robert,

On Tue, Jun 11, 2019 at 4:02 PM Robert Hancock <hancock@sedsystems.ca> wrote:

> > [   13.193578] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000
> > ranges:
> > [   13.200635] imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff ->
> > 0x00000000
> > [   13.201454] imx-sdma 20ec000.sdma: loaded firmware 3.3

Does this problem happen if you don't load an external SDMA firmware?
