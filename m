Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3761472F1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 22:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgAWVF0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 16:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgAWVFZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jan 2020 16:05:25 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA14422522;
        Thu, 23 Jan 2020 21:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579813525;
        bh=1GMzoIPjA/dfgCwyvbdtUGGYT4033oKgJ5EKQbHSDhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YkzYO4256ddbjIHM6dIB//OVCClpgrZ1Ld5Vx63ay1gPgee3qxexhoBUmD0KXXeqh
         dpmD4cZQLEoksSIDd3f6kgTgQTvDSENo6Cuzo7P7318AIwkbPXWZ1M1oFxFzpUnaIk
         VLNnWZ9krVCdhc60jcaFFmwgynG2o9SEf4pGV9uc=
Received: by mail-qk1-f175.google.com with SMTP id 21so4960697qky.4;
        Thu, 23 Jan 2020 13:05:24 -0800 (PST)
X-Gm-Message-State: APjAAAWrGwLJE6Zh2hGYIzpaqKw4/+FKsIyb+55Prhtcmos7Yo8fU89g
        IJVzP8PjBVe7Nic8eYvfbyRwS32vKSTSUArkYg==
X-Google-Smtp-Source: APXvYqz+ren3vYgdEOaGJGlpsG6Ms/Ux9wQDSZzssbEiUZtqVY1BuK/U/Us36Q178Ps7ZYs4faZ784O45fwnh2AQBF8=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr79943qkl.119.1579813524125;
 Thu, 23 Jan 2020 13:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20191231193903.15929-1-robh@kernel.org>
In-Reply-To: <20191231193903.15929-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Jan 2020 15:05:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1xMEWZAj2zZaeXEJjgzQvzH2LSaAdT9=7a3HCxtFbuA@mail.gmail.com>
Message-ID: <CAL_Jsq+1xMEWZAj2zZaeXEJjgzQvzH2LSaAdT9=7a3HCxtFbuA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: Convert Arm Versatile binding to
 DT schema
To:     devicetree@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 1:39 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert the Arm Versatile PCI host binding to a DT schema.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2: no change
>
>  .../devicetree/bindings/pci/versatile.txt     | 59 ------------
>  .../devicetree/bindings/pci/versatile.yaml    | 92 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 93 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/versatile.yaml

Applied to DT tree.

Rob
