Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00971E385F
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 07:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE0FjB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 01:39:01 -0400
Received: from mout.web.de ([212.227.15.4]:53371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE0FjB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 01:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590557927;
        bh=jRzraCRNhHLqoLLF2WO2N50YOVZ/dRJBkrB2YxniWKY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AadxKEA7pYC8yb8S3XQz+skvG+VblJP/2xkH9nw9KQT0GrVoMKqELSkkKTbzKec6t
         KW3oUC9u/rrHkOSGFZaNPRxKKm8RdUS4IcfK3688fZpyc00qel9i174xvocrPYxG1Q
         FTZ42kHSMGdkAPbIdKB+uA3Ghz5tZBf7cv1INoQg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.185.253]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgHKO-1jGWdn0Z0e-00nlbR; Wed, 27
 May 2020 07:38:47 +0200
Subject: Re: [PATCH V2] PCI: qcom: Improve exception handling in
 qcom_pcie_probe()
To:     Qiushi Wu <wu000273@umn.edu>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Kangjie Lu <kjlu@umn.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-kernel@vger.kernel.org
References: <20200527025531.32357-1-wu000273@umn.edu>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d433d44e-2244-70a0-0760-98eddc53976d@web.de>
Date:   Wed, 27 May 2020 07:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527025531.32357-1-wu000273@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BTcjZtm0vdz9e9v5DfgpnGWOmCta8SmaLYW+5RVVbe6psofbkv6
 q6TUOxmk7YKuNQcBwjCzsF7yXNTlzVf3VVTiTX6gtCrMuReaLbNWwlr7tri3YKCfHo6Ps8e
 Y38mZKwbxEex6wuapS0jjMjdfQpATMTr//P85legRoQzRjdJxe0hEQ7ZxKX9CjjWxTT0GD6
 JFVpztkzM3VhN/YYnxxcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pXjFjsEzvbs=:797XwGRDgpFClWLSeBvNdl
 AcVBUHWEzNmgsmcLXa6W1CxoH1FWikr6ISTgNJOebSztcLCYZ73MLJfJ1BxbeymbEYTZy0Wat
 oUcvi5WajjB+3+YCGg1xai1J3c2PmdB2HMnM1Ql6Q0mu7y1zsGHtbAyKZJ0z5OW9cMD3vCoQc
 kw4FREJ22LZaj6qKbS49WYoIGIcxEjj/Ws+7hBdUV+IOCMiCzMFQ4LSEx6+G6UBk0pmGT//bM
 g+nQ6ADsQgm7ObNg8IJ/fqPgFSzQ52Y4eZrDpdXSbW3Fr86/uG09Ox+LHhzsD2+1wD/Vy9fWR
 9SE9VCosG0+6i12H5UYOUk103zleqfGQh/lhChgbgKGsI4TxSr65OhyAnzmr0cdbZEz0CuWiJ
 qNbcxe739pccA9WDZbBrw1kBfql0JjZ5hTmV2H6UdjnyjahUuyBjQnCxeypHq2F+2+vDNqXFK
 9ycNhfluZaiN/Jz++55KTQbMGcGSRCXYvrMUXJxDv7qSGECCXyQ1IAwr6Z1PxyBEb12AtJpzS
 heekXGIOkn9s8nCuGCHDv1wKkLfbLorwf0heFAHm4bZI/t3rjqFVwcf62nWbwRDdSSr1y06j0
 BU6ctAZSdMvnZHuysC0EOGOBk5DyAucyDqNxlkzkJCR6YA2LFEhsKe8oqMb4KcVyKkEb5OhVG
 Pg4+qSxepxQ09OqLy9ONSa851rUC8udEBYbnsK4s2Km2wMTvU01caQob5nMnAziJUoey0US2t
 2P/iNpEJ/4nvQ7H4R2GQd4EAp/hipA3Sh8ajovGV6j++aNUVkCm+osYTo1fC+sHMGZDmKngkO
 jeT9PqmtKlcU6QPtocdur3Tr5qEL6z058WkOlb8Nu8N8lz5SJfK35ZYKe7QMvkFaTCyKNFrwp
 lkSom42tcpnI1A1gystt2JPr5qi4gRyh4pKDE8aloJHEVyIa3JrCJzTDJtxtr2LUmAaZ/Qkq0
 S4AAjpQQmHR7xOn6RDo/9KY/8e2E1E3JA3LyP91DPRInsTWtq+TTz7JmhCh6jwjZGGPuAAniC
 zYJoq6GJk7N+0kG6DIBgQgWn8vLIXOMOQ9dgg/BMrf8agL4Ppqoi3PcU0IHT5zOvXkBuJWqFs
 UpD5pdvwYX2O3eu3mV1X5EPRcND0L0wshC3GObSmH6lUEHDDx9QyPK51xyN7lATAe6YtraJiO
 4NuAtVAEY8mQv1D+m9Q1TH8Zi1lwdPYfiP7ZYlwq+hZAk8wyUAHWv3HDTkwzSRDTgSMRdgRym
 Jf3QFC5/y38j9GDtO
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> 1. pm_runtime_put() =E2=80=A6
=E2=80=A6
> 2. pm_runtime_disable() =E2=80=A6

How do you think about to add blank lines for such enumeration items
and to indent the text below the numbers?


> Co-developed-by: Markus Elfring <Markus.Elfring@web.de>

Will our collaboration evolve in more ways besides patch review?

Regards,
Markus
