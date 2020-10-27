Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD70C29B114
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758966AbgJ0O0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 10:26:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34172 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758961AbgJ0O0n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 10:26:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id t14so895287pgg.1;
        Tue, 27 Oct 2020 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=8dCERS1aOAn6Gww2KNm/tRPPwwG94ccIHNu7AdYm6pQ=;
        b=Ipox/R9xpSBugv9+eDyrnAgmke6LXw722AZzlyx5i3iMQ856K4TVTCrsE+pSotIx3o
         bCWGGTUS43iQ48UbZplUlQtyPRKNZzIG+AgOScJqZlzCynubdc/oX+Aj4wGzkgOdO6sL
         SHj02JPzRvE/5V1PQ7NhgH8o2RGJU53CebLxEPuZHDP3VGMOX7N90PVW2KoD9j8i9u+S
         LTmK/0XHhRKZnTsgHXCyzg6a3oMYQXxejhSNI/txQOvEOMvvdQPJV52hlSpdJJ20UM4G
         oAEiMeMMjXM8wfOR0Nto3so5z3Npp1sOhBfJZM2Z1TE59ko3gawgdF8XNzBd334eMF+p
         n0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=8dCERS1aOAn6Gww2KNm/tRPPwwG94ccIHNu7AdYm6pQ=;
        b=O8IIFIHbnvaJDJZyxyochNGSyaavqAL9Q9GhWj4OCzOmtKg2ebwmMLg74sxXMgA/TE
         SL+PoTskyLZHkzHMO4qbMhxcbO58zc/1HB+WC3of8fk40NreQyU2r/2mCZ+puCueSpxk
         5BfW62Dis21tFkptYPa8X9Nxxid9KH98gcHY7MebbpJ69DTiFRNAhKNW1z9p03/sQkS2
         Fgn5mkOaliVQWvFyajyKdFSPcllU1F0xOmArVnRmfB1GOufuoh3vsh/Ht6/wVms3eqES
         tJNysdESUZanSiDz/XZ6Avj5WR5GlNaM2lxwJpGHjtyYbYONwO0kWyUU6PuQtreo5l+c
         X8JA==
X-Gm-Message-State: AOAM532fLFjWUSTZW85mFBsAO7yCKHXWQqON/chGMsKju+LgDIvJVEEl
        srXRFf9W/NlVVbnZNXt1pgs=
X-Google-Smtp-Source: ABdhPJyrd2Awsck+RaZx+POJO8GSMbSMhCE5F1KOR5IvuLj04c+DhjwBhFjv0LelEa/uuTIpGWsgIw==
X-Received: by 2002:a63:474c:: with SMTP id w12mr2194940pgk.11.1603808802402;
        Tue, 27 Oct 2020 07:26:42 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id o4sm2208827pjj.38.2020.10.27.07.26.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 07:26:41 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH V2 1/2] PCI/AER: Add pcie_is_ecrc_enabled() API
Thread-Topic: [PATCH V2 1/2] PCI/AER: Add pcie_is_ecrc_enabled() API
Thread-Index: AQHWrDe6hxYyrNSnZ0y4OKcgFRibWKmrgeiU
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 27 Oct 2020 14:26:36 +0000
Message-ID: <SLXP216MB0477E54B0D90CB18AA25C3AEAA160@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201027080330.8877-1-vidyas@nvidia.com>
 <20201027080330.8877-2-vidyas@nvidia.com>
In-Reply-To: <20201027080330.8877-2-vidyas@nvidia.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/27/20, 4:03 AM, Vidya Sagar wrote:
>=20
> Adds pcie_is_ecrc_enabled() API to let other sub-systems (like DesignWare=
)
> to query if ECRC policy is enabled and perform any configuration
> required in those respective sub-systems.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> V2:
> * None from V1
>
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/pcie/aer.c | 11 +++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..325fdbf91dde 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -575,9 +575,11 @@ static inline void pcie_aspm_powersave_config_link(s=
truct pci_dev *pdev) { }
>  #ifdef CONFIG_PCIE_ECRC
>  void pcie_set_ecrc_checking(struct pci_dev *dev);
>  void pcie_ecrc_get_policy(char *str);
> +bool pcie_is_ecrc_enabled(void);
>  #else
>  static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
>  static inline void pcie_ecrc_get_policy(char *str) { }
> +static inline bool pcie_is_ecrc_enabled(void) { return false; }
>  #endif
>
>  #ifdef CONFIG_PCIE_PTM
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457a..24363c895aba 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -207,6 +207,17 @@ void pcie_ecrc_get_policy(char *str)
>
>  	ecrc_policy =3D i;
>  }
> +
> +/**
> + * pcie_is_ecrc_enabled - returns if ECRC is enabled in the system or no=
t
> + *
> + * Returns 1 if ECRC policy is enabled and 0 otherwise
> + */
> +bool pcie_is_ecrc_enabled(void)
> +{
> +	return ecrc_policy =3D=3D ECRC_POLICY_ON;
> +}
> +EXPORT_SYMBOL(pcie_is_ecrc_enabled);
>  #endif	/* CONFIG_PCIE_ECRC */
>
>  #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | =
\
> --=20
> 2.17.1

